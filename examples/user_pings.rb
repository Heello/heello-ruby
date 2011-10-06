require '../lib/heello'

heello = Heello::Client.new

heello.configure :app, do |conf|
	conf[:client_id] = "abc123"
	conf[:client_secret] = "def456"
	conf[:redirect_url] = "http://example.com/oauth/finish"
end

heello.configure :user, do |conf|
	conf[:access_token] = "accesstoken"
	conf[:refresh_token] = "refreshtoken"
end

user = heello.users :show, {:id => 3}