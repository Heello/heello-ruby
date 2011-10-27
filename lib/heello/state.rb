module Heello
  class State
    include Configurable
    
    def initialize
      @config = {
      	:value => ""
      }
    end
    
    def to_s
      @config[:value]
    end
  end
end