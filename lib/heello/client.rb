module Heello
  class Client
    attr_accessor :app, :user
    
    def initialize
      @app = Heello::App.new
      @user = Heello::User.new
      @api = Heello::API.new(@app, @user)
    end
    
    def configure(which, &block)
      if [:app, :user].include? which
        self.instance_variable_get("@#{which}").configure &block
      else
        throw ArgumentError, "Invalid configuration parameter given"
      end
    end
    
    def method_missing(method, *args, &block)
      if @api.endpoint_exists? method.to_s
        @api.execute_api method.to_s, args
      else
        super
      end
    end
  end
end