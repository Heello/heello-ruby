module Heello; end

def require_local(path)
  require(File.expand_path(File.join(File.dirname(__FILE__), path)))
end

# Load required libraries
require 'json'
require 'nestful'
require 'uri'

# Load library files
require_local 'heello/util'
require_local 'heello/configurable'
require_local 'heello/state'
require_local 'heello/api'
require_local 'heello/app'
require_local 'heello/client'
require_local 'heello/user'