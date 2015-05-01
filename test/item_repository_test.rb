require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :items, :engine

  def setup
    @engine    = SalesEngine.new('./test/fixtures')
    @items = engine.item_repository
  end

  def test_items_repository_exists
    assert items
  end

  def test_items_repository_contains_data
    assert_equal 100, items.all.length
  end

  def test_item_repository_returns_all_items
    assert_equal 100, items.all.length
  end

  def test_item_repository_returns_random_item
    item1, item2 = items.random, items.random

    total_random_items = 0
    until total_random_items == 100
      total_random_items += 1 if item1 == item2
      return total_random_items
    end

    assert_equal 100, total_random_items
  end

  def test_item_repository_returns_item_by_id
    by_id = items.find_by_id(5)
    assert_equal 68723, by_id.unit_price
  end

  def test_item_repository_returns_item_by_name
    skip
    by_name = items.find_by_name()
  end
end
