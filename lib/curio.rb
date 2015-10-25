# encoding: utf-8

require 'curio/version'

require 'forwardable'

# A mixin to define enumerable maps
class Curio < Module
  # Error raised when fetch cannot find an item with key
  class NotFoundError < KeyError
    def initialize(key)
      @key = key
      super "Item not found in collection with key: #{key}"
    end
  end

  # Initialize a collection object with given key and type
  #
  # :key will be used to determine which method to call on items to get
  # their unique identifier when adding them to the collection.
  #
  # :type will be used to determine how to coerce the input when calling
  # methods on the collection.
  #
  # @param [Symbol] key
  # @param [Class] type
  #
  # @return [undefined]
  #
  # @api private
  def initialize(key, type = String)
    @key = key
    @type = type

    define_key_method
    define_coerce_key_method

    freeze
  end

  private
  # Hook called when module is included
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  def included(descendant)
    super

    descendant.module_eval do
      include Enumerable
      include Methods
    end
  end

  # Define #key_method based on @key
  #
  # @return [undefined]
  #
  # @api private
  def define_key_method
    key = @key
    define_method :key_method do
      key
    end
  end

  # Define #coerce_key based on @type
  #
  # @return [undefined]
  #
  # @api private
  def define_coerce_key_method
    type = @type
    define_method :coerce_key do |value|
      case type.to_s
      when 'String'  then "#{value}"
      when 'Symbol'  then :"#{value}"
      when 'Integer' then "#{value}".to_i
      else value
      end
    end
  end

  # The collection methods
  module Methods
    extend Forwardable

    # Iterate over each item in the collection
    #
    # @yield [object]
    #
    # @return [Enumerator]
    #
    # @api public
    def_delegators :values, :each

    # Last item in the collection
    #
    # @return [object]
    #
    # @api public
    def_delegators :values, :last

    # Setup the map and call parent initializer
    #
    # @return [undefined]
    #
    # @api private
    def initialize(*)
      @map = { }
      super
    end

    # Get all the items in collection
    #
    # @return [Array]
    #
    # @api public
    def values
      @map.values
    end
    alias_method :all, :values

    # Add an item to the collection
    #
    # @param [object] item
    #
    # @return [self]
    #
    # @api public
    def <<(item)
      key = coerce_key item.send(key_method)
      @map[key] = item
      self
    end

    # Fetch an item from the collection
    #
    # @yield [undefined]
    #
    # @param [undefined] key
    # @param [undefined] default
    #
    # @return [object]
    #
    # @api public
    def fetch(key, *args, &block)
      args.unshift coerce_key(key)
      @map.fetch(*args, &block)
    rescue KeyError
      raise NotFoundError, key
    end

    # Get an item from the collection
    #
    # @param [undefined] key
    #
    # @return [object]
    #
    # @api public
    def [](key)
      fetch key, nil
    end

    # Check if collection has an item with specified key
    #
    # @param [undefined] key
    #
    # @return [Boolean]
    #
    # @api public
    def key?(key)
      @map.key? coerce_key(key)
    end
    alias_method :has?, :key?

    # Returns a hash representation of the collection
    #
    # @return [Hash]
    #
    # @api public
    def to_h
      @map
    end
  end
end
