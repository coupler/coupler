module Coupler
  module Models
    class Field < Sequel::Model
      include CommonModel
      many_to_one :resource
      one_to_many :transformations, :key => :source_field_id

      TYPES = {
        'integer'  => {:type => Integer},
        'string'   => {:type => String, :size => 255},
        'datetime' => {:type => DateTime}
      }

      def local_column_options
        { :name => name, :primary_key => is_primary_key }.merge!(TYPES[final_type])
      end

      def final_type
        local_type || self[:type]
      end

      def final_db_type
        local_db_type || db_type
      end

      def scenarios_dataset
        marshalled_id = [Marshal.dump(id)].pack('m')
        Scenario.
          select(:scenarios.*).
          filter({:project_id => resource.project_id} & ({:resource_1_id => resource_id} | {:resource_2_id => resource_id})).
          join(Matcher, :scenario_id => :id).
          join(Comparison, :matcher_id => :id).
          filter({:lhs_type => 'field', :raw_lhs_value => marshalled_id} | {:rhs_type => 'field', :raw_rhs_value => marshalled_id})
      end

      def name_sym
        @name_sym ||= name.to_sym
      end

      private
        def validate
          super
          validates_presence [:name, :resource_id]
          validates_unique [:name, :resource_id]
        end

        def before_save
          super
          case is_primary_key
          when TrueClass, 1
            self.is_selected = 1
          end
        end
    end
  end
end
