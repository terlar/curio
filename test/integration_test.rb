require_relative 'test_helper'
require 'pry'

# rubocop: disable ClassLength
class IntegrationTest < Minitest::Test
  class Collection
    include Curio.new(:id)
  end

  # Dummy class used for testing
  Item = Struct.new(:id)

  attr_reader :collection

  def setup
    @collection = Collection.new
  end

  def test_enumerable_behavior
    assert_kind_of Enumerable, collection
    assert_instance_of Enumerator, collection.each
  end

  def test_retrieving_last_item
    last_item = Item.new 2
    collection << Item.new(1) << last_item

    assert_equal last_item, collection.last
  end

  def test_retriving_all_items
    all_items = [Item.new(1), Item.new(2)]
    collection << all_items[0] << all_items[1]

    assert_equal all_items, collection.all
    assert_equal all_items, collection.values
  end

  def test_retrieving_an_item
    item = Item.new 'a'
    collection << item

    found = collection['a']
    assert_equal item, found
  end

  def test_retrieving_an_item_with_fetch
    item = Item.new 'a'
    collection << item

    found = collection.fetch 'a'
    assert_equal item, found
  end

  def test_retrieving_unknown_item
    found = collection['a']
    assert_nil found
  end

  def test_retrieving_unknown_item_with_fetch
    assert_raises Curio::NotFoundError do
      collection.fetch 'a'
    end
  end

  def test_retrieving_unknown_item_with_fetch_and_default_value
    found = collection.fetch 'a', 'bang'
    assert_equal 'bang', found
  end

  def test_retrieving_unknown_item_with_fetch_and_default_block
    found = collection.fetch('a') { 'bang' }
    assert_equal 'bang', found
  end

  def test_adding_an_item
    item = Item.new 1
    collection.add item

    assert_includes collection, item
    assert_equal 1, collection.count
  end

  def test_adding_an_item_with_shovel_operator
    item = Item.new 1
    collection << item

    assert_includes collection, item
    assert_equal 1, collection.count
  end

  def test_item_is_known
    collection << Item.new('a')

    assert collection.key? 'a'
    assert collection.has? 'a'
    refute collection.key? 'b'
    refute collection.has? 'b'
  end

  def test_hash_representation
    item1 = Item.new 'a'
    item2 = Item.new 'b'
    collection << item1 << item2

    assert_equal({ 'a' => item1, 'b' => item2 }, collection.to_h)
  end

  def test_coerces_key_from_string
    item = Item.new 1
    collection << item

    found = collection.fetch '1'
    assert_equal item, found
  end

  def test_coerces_key_from_symbol
    item = Item.new 1
    collection << item

    found = collection.fetch :'1'
    assert_equal item, found
  end

  def test_change_map_source
    other_map = { }

    collection.map = other_map
    collection << Item.new(1)

    assert_equal collection.to_h, other_map
  end

  def test_supports_freeze
    collection.freeze

    assert collection.frozen?
    assert collection.to_h.frozen?
  end

  def test_freeze_freezes_items
    collection << Item.new(1)
    collection.freeze

    assert collection.first.frozen?
  end
end
# rubocop: enable ClassLength
