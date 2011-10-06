module Heello
  class App
    include Configurable
    
    def initialize
      @config = {
        "client_id" => nil,
        "client_secret" => nil
      }
    end
  end
end