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
    assert_equal 101, items.all.length
  end

  def test_item_repository_returns_all_items
    assert_equal 101, items.all.length
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

#Find_by Methods
  def test_item_repository_returns_item_by_id
    by_id = items.find_by_id(5)
    assert_equal 68723, by_id.unit_price
  end

  def test_item_repository_returns_item_by_name
    by_name = items.find_by_name("Item Provident At")
    assert_equal 6, by_name.id
  end

  def test_item_repositoyr_returns_item_by_description
    by_description = items.find_by_description("Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.")
    assert_equal 6, by_description.id
  end

  def test_item_repository_returns_item_by_unit_price
    by_unit_price = items.find_by_unit_price(15925)
    assert_equal 6, by_unit_price.id
  end

  def test_item_repository_retuns_item_by_merchant_id
    by_merchant_id = items.find_by_merchant_id(1)
    assert_equal 15, by_merchant_id.count
  end

  def test_item_repository_returns_item_by_created_at
    by_created_at = items.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, by_created_at.id
  end

  def test_item_repository_returns_items_by_updated_at
    by_updated_at = items.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, by_updated_at.id
  end

#Find_by_all Methods
  def test_item_repository_returns_all_items_by_id
    all_by_id = items.find_all_by_id(1)
    assert_equal 1, all_by_id.count
    assert all_by_id.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_name
    all_by_name = items.find_all_by_name("Item Provident At")
    assert_equal 1, all_by_name.count
    assert all_by_name.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_description
    all_by_description = items.find_all_by_description("Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.")
    assert_equal 1, all_by_description.count
    assert all_by_description.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_unit_price
    all_by_unit_price = items.find_all_by_unit_price(15925)
    assert_equal 1, all_by_unit_price.count
    assert all_by_unit_price.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_merchant_id
    all_by_merchant_id = items.find_all_by_merchant_id(1)
    assert_equal 15, all_by_merchant_id.count
    assert all_by_merchant_id.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_created_at
    all_by_created_at = items.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 100, all_by_created_at.count
    assert all_by_created_at.first.is_a?(Item)
  end

  def test_item_repository_returns_all_items_by_updated_at
    all_by_updated_at = items.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 101, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(Item)
  end
end
