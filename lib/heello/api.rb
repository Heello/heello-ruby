module Heello
  API_SECURE = false
  API_BASE = 'api.heello.com'
  API_VERSION = 1
  
  class API
    def initialize(app, user, state)
      @api = {}
      @app = app
      @user = user
      @state = state
      
      @endpoint = nil
      @action = nil
      @params = nil
      
      api_file = File.open(File.dirname(__FILE__) + "/../api.json", "rb")
      api_def = JSON.parse(api_file.read)
      
      self.build_api(api_def)
    end
    
    def endpoint_exists?(endpoint)
      @api.has_key? endpoint
    end
    
    def execute_api(endpoint, args)
      raise "Invalid API action given for #{endpoint} endpoint" if @api[endpoint].has_key?(args[0])
      
      @endpoint = endpoint.to_s
      @action = args[0].to_s
      @params = args[1]
      
      self.validate_args()
      self.check_for_authentication()
      
      if self.endpoint_options['method'] == "GET"
        resp = Nestful.get(self.get_url, :params => @params)
      else
        resp = Nestful.post(self.get_url, :params => @params)
      end
      
      self.reset_parameters()
      JSON.parse(resp)
    end
    
    def get_url_base
      url = "http" + (API_SECURE ? "s" : "") + "://"
      url += API_BASE + "/"
      url += API_VERSION.to_s + "/"
    end
    
    protected
    
    def build_api(api_def)
      api_def.each do |endpoint, actions|
        @api[endpoint] = {}

        actions.each do |action, options|
          @api[endpoint][action] = options
        end
      end
    end
    
    def validate_args()
      return if not self.endpoint_options.has_key? "required_params"
      
      self.endpoint_options['required_params'].each do |param|
        raise "Missing required parameter '#{param}' for #{@endpoint}/#{@action}" if !@params.has_key?(param.to_sym)
      end
    end
    
    def check_for_authentication()
      return if not self.endpoint_options.has_key? "requires_auth" or self.endpoint_options["requires_auth"] == false      
      raise "Attempting to call write-enabled endpoint without user credentials" if not @user.configured?
      
      @params[:access_token] = @user.access_token
    end
    
    def endpoint_options
      @api[@endpoint][@action]
    end
    
    def get_url
      url = self.get_url_base
      if not self.endpoint_options.has_key?("url")
        url += "#{@endpoint}/#{@action}.json"
        return url
      end
      
      url += "#{@endpoint}/#{self.endpoint_options['url']}.json"

      if not url[":"].nil?
        url = url.gsub /(:[A-Za-z_]+)/, do |match|
          @params[match[1..-1].to_sym].to_s
        end
      end

      url
    end
    
    def reset_parameters
      @endpoint = nil
      @action = nil
      @params = nil
    end
  end
end