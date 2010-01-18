module Coupler
  class Base < Sinatra::Base
    def self.run!(*args)
      scheduler = Scheduler.instance
      scheduler.start
      at_exit { scheduler.shutdown }
      super
    end

    set :root, COUPLER_ROOT
    set :static, true
    #set :port, 37222
    set :raise_errors, Proc.new { test? }
    set :show_exceptions, Proc.new { development? }
    set :dump_errors, true
    set :logging, Proc.new { !test? }
    set :methodoverride, true
    enable :sessions

    use Rack::Flash
    register Extensions::Projects
    register Extensions::Resources
    register Extensions::Transformations
    register Extensions::Scenarios
    register Extensions::Matchers
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

    get "/test" do
      erb :lorem_ipsum
    end
  end
end
