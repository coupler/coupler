module Coupler
  class Base < Sinatra::Base
    def self.run!(*args)
      scheduler = Scheduler.instance
      scheduler.start
      at_exit { scheduler.shutdown }
      super
    end

    set :root, File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "webroot"))
    set :static, true
    #set :port, 37222
    set :erb, :trim => '-'
    set :raise_errors, Proc.new { test? }
    set :show_exceptions, Proc.new { development? }
    set :dump_errors, true
    set :logging, Proc.new { !test? }
    set :methodoverride, true
    enable :sessions

    use Rack::Flash
    register Extensions::Connections
    register Extensions::Projects
    register Extensions::Resources
    register Extensions::Transformations
    register Extensions::Scenarios
    register Extensions::Matchers
    register Extensions::Results
    register Extensions::Jobs
    register Extensions::Transformers
    helpers do
      include Coupler::Helpers
      include Rack::Utils
      alias_method :h, :escape_html
    end

    get "/" do
      if Models::Project.count > 0
        redirect "/projects"
      else
        erb :index
      end
    end
  end
end
