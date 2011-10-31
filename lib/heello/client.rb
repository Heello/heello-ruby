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
    
    def finish_authorization(args)
      raise "Problem finishing Heello API authentication: #{args.error}" if args.has_key? "error"
      raise "Invalid state: given #{args[:state]} expecting #{@state.value}" if args[:state] != @state.value
      
      params = {
        :client_id => @app.client_id,
        :client_secret => @app.client_secret,
        :redirect_uri => @app.redirect_url,
        :code => args[:code],
        :response_type => 'token',
        :grant_type => 'authorization_code'
      }
      
      endpoint = @api.get_url_base + "/oauth/token"
      resp = Nestful.post(endpoint, :params => params)
      
      self.configure :user, do |conf|
        conf[:access_token] = resp[:access_token]
        conf[:refresh_token] = resp[:refresh_token]
      end
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