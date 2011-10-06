module Heello; end

def require_local(path)
  require(File.expand_path(File.join(File.dirname(__FILE__), path)))
end

# Load required libraries
require 'json'
require 'nestful'

# Load library files
Dir.glob(File.dirname(__FILE__) + "/heello/*") {|file| require file}