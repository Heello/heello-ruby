module Heello
  class Client
    attr_accessor :app, :user
    
    def initialize
      @app = Heello::App.new
      @user = Heello::User.new
      @api = Heello::API.new
    end
    
    def configure(which, &block)
      if self[which].exists?
        self[which].configure block
      else
        throw ArgumentError, "Invalid configuration parameter given"
      end
    end
  end
end