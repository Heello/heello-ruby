module Heello
  class User
    include Configurable
    
    def initialize
      @config = {
        :access_token => nil,
        :refresh_token => nil
      }
    end
    
    def configured?
      not @config[:access_token].nil? and not @config[:refresh_token].nil?
    end
  end
end