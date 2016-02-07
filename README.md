# feedcellar-test

A testing tool for [Feedcellar](http://myokoym.net/feedcellar).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feedcellar-test'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feedcellar-test

## Usage

Start server for sample RSS feed (http://localhost:20075/feed.xml):

    $ feedcellar-test server start

Or

```ruby
require "feedcellar/test/command"

server = Feedcellar::Test::Server.new
server.start
# use http://localhost:20075/feed.xml
server.stop
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/feedcellar/feedcellar-test.

