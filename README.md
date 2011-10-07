# About the Project

The Heello API library provides simple-to-use access to the Heello API and takes care of all the OAuth headaches for you.

## Dependencies

* json
* Nestful

## Examples

### Providing an Authorization Link

TODO

### Finishing Authorization

TODO

### Handling Refresh Tokens

In OAuth 2, access tokens only last so long before they expire and require re-issuing. This is where the refresh token comes into play. This is handled automatically by the library. To be notified when a new access token is issued, and to save the new token, you can use:

TODO

### Getting Information from the API

```ruby
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

user = heello.users :show, {:id => 10}
puts user.username
```

## Contributors

* [Ryan LeFevre](http://heello.com/meltingice)