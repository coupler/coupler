module Coupler
  module Extensions
    module Scenarios
      def self.registered(app)
        app.get '/projects/:project_id/scenarios' do
          @scenarios = @project.scenarios
          erb :'scenarios/index'
        end

        app.get '/projects/:project_id/scenarios/new' do
          @scenario = Models::Scenario.new
          erb 'scenarios/new'.to_sym
        end

        app.post "/projects/:project_id/scenarios" do
          @scenario = Models::Scenario.new(params[:scenario])
          @scenario.project = @project

          if @scenario.save
            flash[:newly_created] = true
            redirect "/projects/#{@project.id}/scenarios/#{@scenario.id}"
          else
            erb 'scenarios/new'.to_sym
          end
        end

        app.get '/projects/:project_id/scenarios/:id' do
          @scenario = @project.scenarios_dataset[:id => params[:id]]
          @resources = @scenario.resources
          @matcher = @scenario.matcher
          @results = @scenario.results
          @running_jobs = @scenario.running_jobs
          @scheduled_jobs = @scenario.scheduled_jobs
          erb 'scenarios/show'.to_sym
        end

        app.get "/projects/:project_id/scenarios/:id/run" do
          @scenario = @project.scenarios_dataset[:id => params[:id]]
          Scheduler.instance.schedule_run_scenario_job(@scenario)
          redirect "/projects/#{@project.id}/scenarios/#{@scenario.id}"
        end

        #app.get "/projects/:project_id/scenarios/:id/progress" do
          #scenario = Models::Scenario[:id => params[:id], :project_id => params[:project_id]]
          #(scenario[:completed] * 100 / scenario[:total]).to_s
        #end
      end
    end
  end
end
