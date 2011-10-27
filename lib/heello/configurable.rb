module Configurable
  def configure(&block)
    raise ArgumentError, "Block required in order to configure" unless block_given?
    yield @config
  end
  
  def method_missing(method, *args, &block)
    if @config.has_key? method.to_sym
      @config[method.to_sym]
    else
      super
    end
  end
end