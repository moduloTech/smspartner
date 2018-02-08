# Smspartner

This gem allows you to simply send SMS via the smspartner.fr API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smspartner', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smspartner

## Usage

You first need to configure the gem before using the SMS sending feature :

```ruby
Smspartner.configure do |config|
  # fetch your API key from a file
  config.api_key = File.read(Rails.root.join('api_keys', 'sms_partner'))
  # or from the environment
  # config.api_key = ENV['sms_partner_api_key']

  config.sender = '11 chars max'

  # default values
  # config.sandbox = false
  # config.range_value = :premium # valid values are %i[premium low_cost]

end
```

Rails users: put this code inside `config/initializers/smspartner.rb`

To send a SMS, simply do the following

```ruby
res = Smspartner.send_sms to: phone_number, body: sms_body

if res.success?
  puts "You should store the message's id: #{res.message_id}"
else
  warn "Failed to send SMS because: #{res.errors.join("\n")}"
end

puts JSON.pretty_generate res.raw_data
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moduloTech/smspartner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Smspartner project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/moduloTech/smspartner/blob/master/CODE_OF_CONDUCT.md).
