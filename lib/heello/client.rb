module Heello
  class Client
    attr_reader :app, :user
    
    def initialize
      @app = Heello::App.new
      @user = Heello::User.new
      @state = Heello::State.new
      @api = Heello::API.new(@app, @user, @state)
    end
    
    def configure(which, &block)
      if [:app, :user, :state].include? which
        self.instance_variable_get("@#{which}").configure &block
      else
        throw ArgumentError, "Invalid configuration parameter given"
      end
    end
    
    def authorization_url(display = "full")
      raise "Client credentials required to build authorization URL" if self.mode == :nocreds
      
      url = @api.get_url_base
      url += "oauth/authorize?"
      
      params = {
        :client_id => @app.client_id,
        :response_type => "code",
        :redirect_uri => @app.redirect_url,
        :state => @state,
        :display => display
      }
      
      url += params.to_query
    end
    
    def method_missing(method, *args, &block)
      if @api.endpoint_exists? method.to_s
        @api.execute_api method.to_s, args
      else
        super
      end
    end
    
    protected
    
    def mode
      return :nocreds if @app.client_id.nil? or @app.client_secret.nil?
      return :readonly if @user.access_token.nil?
      return :readwrite
    end
  end
end