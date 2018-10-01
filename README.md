# AdbExtended

A wrapper around `adb` to handle working with more than 1 device plugged in at a time

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adb_extended'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adb_extended

## Usage

This is intended as a commandline application. The options are as follows:

- adb_extended ashell             # Lists the devices and allows you to choose one to run the shell on
- adb_extended devices            # Lists the Android devices with a little more info
- adb_extended help [COMMAND]     # Describe available commands or one specific command
- adb_extended install PATH       # Installs the provided apk on the selected device
- adb_extended logcat PACKAGE     # Lists the devices and allows you to choose one to run with logcat
- adb_extended pidcat PACKAGE     # Lists the devices and allows you to choose one to run with pidcat (requires `pidcat` to be installed and available in the path)
- adb_extended uninstall PACKAGE  # Uninstalls the provided package on the selected device


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/daentech/adb_extended. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdbExtended project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/daentech/adb_extended/blob/master/CODE_OF_CONDUCT.md).
