# About the Project

The Heello API library provides simple-to-use access to the Heello API and takes care of all the OAuth headaches for you.

## Dependencies

* json
* Nestful

## Examples

### Configuration

This should always happen before making any API calls, although the configuration is not required for read-only queries.

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

heello.configure :state, do |state|
  # This is dependent on your framework, but should identify
  # the active session in some consistent way.
  state[:value] = Digest::MD5.hexdigest("test")
end
```

### Providing an Authorization Link

You can optionally provide an argument to authorization_url() to specify the display type. Options are 'popup' or 'full'.

```html
<a href="<%=heello.authorization_url%>">Login with Heello</a>
```

### Finishing Authorization

TODO

### Handling Refresh Tokens

In OAuth 2, access tokens only last so long before they expire and require re-issuing. This is where the refresh token comes into play. This is handled automatically by the library. To be notified when a new access token is issued, and to save the new token, you can use:

TODO

### Getting Information from the API


```ruby
ping = heello.pings :create, {:text => "Hello, world!"}
puts ping.id
```

## Contributors

* [Ryan LeFevre](http://heello.com/meltingice)