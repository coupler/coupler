module Coupler
  module Models
    class Scenario < Sequel::Model
      class NoMatcherError < Exception; end
      class ResourcesOutOfDateError < Exception; end

      include CommonModel
      include Jobify

      attr_writer :resource_ids
      many_to_one :project
      many_to_one :resource_1, :class => "Coupler::Models::Resource"
      many_to_one :resource_2, :class => "Coupler::Models::Resource"
      one_to_one :matcher
      one_to_many :results

      def self.count_by_project
        dataset.naked.group_and_count(:project_id).to_hash(:project_id, :count)
      end

      def status
        if matcher.nil?
          "no_matcher"
        elsif resources.any? { |r| r.status == "out_of_date" }
          "resources_out_of_date"
        else
          "ok"
        end
      end

      def resources
        if resource_1
          resource_2 ? [resource_1, resource_2] : [resource_1]
        else
          []
        end
      end

      def local_database(&block)
        Sequel.connect(local_connection_string, {
          :loggers => [Coupler::Logger.instance],
          :max_connections => 50,
          :pool_timeout => 60
        }, &block)
      end

      def run!(&progress)
        case status
        when 'no_matcher'             then raise NoMatcherError
        when 'resources_out_of_date'  then raise ResourcesOutOfDateError
        end

        runner = Runner.new(self, &progress)
        runner.run!

        update(:run_count => run_count + 1, :last_run_at => Time.now)
        result = Result.new(:scenario => self, :run_number => run_count)
        result.save
      end

      def set_linkage_type
        if resource_1
          if resource_2
            self.linkage_type = "dual-linkage"
          elsif matcher && matcher.cross_match?
            self.linkage_type = "cross-linkage"
          else
            self.linkage_type = "self-linkage"
          end
        else
          self.linkage_type = "N/A"
        end
      end

      private

        def local_connection_string
          Coupler.connection_string("scenario_#{id}")
        end

        def before_validation
          super
          if @resource_ids.is_a?(Array)
            objects = project.resources_dataset.filter(:id => @resource_ids[0..1].compact).all
            self.resource_1_id = objects[0].nil? ? nil : objects[0].id
            self.resource_2_id = objects[1].nil? ? nil : objects[1].id
          end
        end

        def validate
          super
          validates_presence :name
          validates_unique [:name, :project_id]
          if resource_1_id.nil?
            errors.add(:base, "At least one resource is required")
          end
        end

        def before_create
          super
          self.slug ||= name.downcase.gsub(/\s+/, "_")
          set_linkage_type
        end

        # There is currently no plan to let a user change resources
        # after a scenario has been created.
        #def before_update
          #super
          #set_linkage_type
        #end
    end
  end
end

require File.join(File.dirname(__FILE__), 'scenario', 'runner')
