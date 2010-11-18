require File.dirname(__FILE__) + '/../../helper'

module Coupler
  module Extensions
    class TestScenarios < Test::Unit::TestCase
      def setup
        super
        @project = Factory(:project)
      end

      def test_index
        scenario = Factory(:scenario, :project => @project)
        get "/projects/#{@project.id}/scenarios"
        assert last_response.ok?
      end

      def test_index_of_non_existant_project
        get "/projects/8675309/scenarios"
        assert last_response.redirect?
        assert_equal "http://example.org/projects", last_response['location']
        follow_redirect!
        assert_match /The project you were looking for doesn't exist/, last_response.body
      end

      def test_show
        scenario = Factory(:scenario, :project => @project)
        get "/projects/#{@project.id}/scenarios/#{scenario.id}"
        assert last_response.ok?
      end

      def test_new
        get "/projects/#{@project.id}/scenarios/new"
        assert last_response.ok?
      end

      def test_successfully_creating_scenario
        resource = Factory(:resource, :project => @project)
        attribs = Factory.attributes_for(:scenario)
        post "/projects/#{@project.id}/scenarios", { 'scenario' => attribs.merge('resource_ids' => [resource.id]) }
        scenario = Models::Scenario[:name => attribs[:name], :project_id => @project.id]
        assert scenario
        assert_equal [resource], scenario.resources

        assert last_response.redirect?, "Wasn't redirected"
        follow_redirect!
        assert_equal "http://example.org/projects/#{@project.id}/scenarios/#{scenario.id}", last_request.url
      end

      def test_failing_to_create_scenario
        post "/projects/#{@project.id}/scenarios", {
          'scenario' => Factory.attributes_for(:scenario, :name => nil)
        }
        assert last_response.ok?
        assert_match /Name is not present/, last_response.body
      end

      def test_run_scenario
        scenario = stub("scenario", :new? => false, :name => "foo", :slug => "foo", :id => 1)
        @scheduler = mock("scheduler") do
          expects(:schedule_run_scenario_job).with(scenario)
        end
        Scheduler.stubs(:instance).returns(@scheduler)
        Models::Project.stubs(:[]).returns(@project)
        @project.stubs(:scenarios_dataset).returns(stub("scenarios dataset", :[] => scenario))
        get "/projects/#{@project.id}/scenarios/123/run"
        assert last_response.redirect?, "Wasn't redirected"
      end

      #def test_progress
        #scenario = Factory(:scenario, :project => @project, :completed => 100, :total => 1000)
        #get "/projects/#{@project.id}/scenarios/#{scenario.id}/progress"
        #assert last_response.ok?
        #assert_equal "10", last_response.body
      #end
    end
  end
end
