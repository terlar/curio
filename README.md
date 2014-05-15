# Curio

A module to ease creation of collections and enumerable maps

[![Gem Version](https://badge.fury.io/rb/curio.svg)](http://badge.fury.io/rb/curio)
[![Build
Status](https://travis-ci.org/terlar/curio.svg)](https://travis-ci.org/terlar/curio)
[![Code Climate](https://codeclimate.com/github/terlar/curio.png)](https://codeclimate.com/github/terlar/curio)

## Installation

Add this line to your application's Gemfile:

    gem 'curio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install curio

## Usage

```ruby
Item = Struct.new :id

class Collection
  include Curio.new :id, Integer
end

collection = Collection.new
collection << Item.new(1)
collection << Item.new(2)

collection.fetch 1            # => #<struct Item id=1>
collection.fetch '1'          # => #<struct Item id=1>
collection.fetch 3            # => Curio::NotFoundError: Item not found in collection with key: 3
collection.fetch 3, :default  # => :default
collection.fetch 3 do
  :default
end                           # => :default

collection[1]                 # => #<struct Item id=1>
collection['1']               # => #<struct Item id=1>
collection[3]                 # => nil

collection.key? 1             # => true
collection.key? '1'           # => true
collection.key? 3             # => false

collection.all                # => [#<struct Item id=1>, #<struct Item id=2>]
collection.last               # => #<struct Item id=2>

collection.each do |item|
  puts item.id
end                           # => 1 2
```

## Contributing

1. Fork it ( https://github.com/terlar/curio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
