module Heello
  class App
    include Configurable
    
    def initialize
      @config = {
        "client_id" => nil,
        "client_secret" => nil,
        "redirect_url" => nil
      }
    end
  end
end