require_relative 'test_helper'

class AutoIncrementTest < Minitest::Test
  class Collection
    include Curio.new(:id, Integer, auto_increment: true)
  end

  Item = Struct.new(:id)

  attr_reader :collection

  def setup
    @collection = Collection.new
  end

  def test_auto_increment_sets_item_key
    item1 = Item.new
    item2 = Item.new
    collection << item1 << item2

    assert_equal 1, item1.id
    assert_equal 2, item2.id
  end

  def test_auto_increment_only_activates_with_missing_item_key
    item1 = Item.new 5
    item2 = Item.new
    collection << item1 << item2

    assert_equal 5, item1.id
    assert_equal 2, item2.id
  end

  def test_auto_increment_items_can_be_fetched
    item1 = Item.new
    item2 = Item.new
    collection << item1 << item2

    assert_equal item1, collection[1]
    assert_equal item2, collection[2]
  end

  def test_auto_increment_with_non_integer_raises_contstraint_error
    assert_raises Curio::ConstraintError do
      Class.new do
        include Curio.new(:id, String, auto_increment: true)
      end
    end
  end
end
