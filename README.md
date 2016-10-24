# Sqlar

This is a Ruby Gem for createing SQLite Archive compatiable files.

SQLite Archiver is a tool for embedding files in a SQLite database. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sqlar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sqlar

## Usage

Inserting a file into a sqlar:

```ruby
sqlar = Sqlar::Sqlar.new("test.sqlite3")
blob = sqlar.get_blob("test/test.jpg")
sqlar.insert(blob)	
```
Extracting files from a sqlar:
```ruby
sqlar = Sqlar::Sqlar.new("test/existing_test.sqlite")
sqlar.extract_all()
```

Extracting a specific file from a sqlar:

```ruby
sqlar = Sqlar::Sqlar.new("test/existing_test.sqlite")
sqlar.extract('Users/jlittle/Desktop/0-0-0.jpg')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sqlar.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

