module Heello
  class API
    def initialize
      @api = {}
      @endpoint = nil
      @action = nil
      
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
      params = args[1]
      
      self.validate_args params
      
      puts "Querying #{@endpoint}/#{@action} with #{params.inspect}"
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
    
    def validate_args(args)
      return if not self.endpoint_options.has_key? "required_params"
      
      self.endpoint_options['required_params'].each do |param|
        raise "Missing required parameter '#{param}' for #{@endpoint}/#{@action}" if !args.has_key?(param)
      end
    end
    
    def endpoint_options
      @api[@endpoint][@action]
    end
  end
end