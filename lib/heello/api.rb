module Heello
  class API
    def initialize
      @api = {}
      
      api_file = File.open(File.dirname(__FILE__) + "/../api.json", "rb")
      api_def = JSON.parse(api_file.read)
      
      self.buildAPI(api_def)
    end
    
    private
    
    def buildAPI(api_def)
      api_def.each do |endpoint, actions|
        @api[endpoint] = {}

        actions.each do |action, options|
          @api[endpoint][action] = options
        end
      end
    end
  end
end