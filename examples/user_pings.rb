require 'digest'

require '../lib/heello'

heello = Heello::Client.new

heello.configure :app, do |conf|
	conf[:client_id] = "abc123"
	conf[:client_secret] = "def456"
	conf[:redirect_url] = "http://example.com/oauth/finish"
end

heello.configure :user, do |conf|
	conf[:access_token] = "8159eea5b55f84e5d061cce17948e9cbf98ce067e"
	conf[:refresh_token] = "81b41bb05222659cd230b409573528865da1e4477"
end

heello.configure :state, do |state|
  state[:value] = Digest::MD5.hexdigest("test")
end

ping = heello.pings :create, {:text => "Hello, World!"}
puts ping.inspect