# encoding: utf-8

require_relative 'test_helper'

class IntegrationTest < MiniTest::Unit::TestCase
  class Collection
    include Curio.new(:id)
  end

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
    item1 = Item.new 1
    item2 = Item.new 2
    collection << item1 << item2

    assert_equal item2, collection.last
  end

  def test_retriving_all_items
    item1 = Item.new 1
    item2 = Item.new 2
    collection << item1 << item2

    assert_equal [item1, item2], collection.all
    assert_equal [item1, item2], collection.values
  end

  def test_retrieving_item
    item = Item.new 'a'
    collection << item

    found = collection['a']
    assert_equal item, found

    found = collection.fetch 'a'
    assert_equal item, found
  end

  def test_retrieving_unknown_item
    found = collection['a']
    assert_equal nil, found

    assert_raises Curio::NotFoundError do
      collection.fetch 'a'
    end

    found = collection.fetch 'a', 'bang'
    assert_equal 'bang', found

    found = collection.fetch('a') { 'bang' }
    assert_equal 'bang', found
  end

  def test_adding_an_item
    item = Item.new 1

    assert_equal 0, collection.count
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

    assert_equal({
      'a' => item1,
      'b' => item2
    }, collection.to_h)
  end

  def test_coerces_key
    item = Item.new 1
    collection << item

    found = collection.fetch '1'
    assert_equal item, found

    found = collection.fetch :'1'
    assert_equal item, found
  end
end
