require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :items, :engine

  def setup
    @engine    = SalesEngine.new('./test/fixtures')
    @items = engine.item_repository
  end


  # -------------------- Relationship Test Methods ------------------------

  def test_item_invoice_items_returns_its_invoice_items
    item = engine.item_repository.find_by_id(1830)
    invoice_items = item.invoice_items

    assert invoice_items.is_a?(Array)
    assert invoice_items.first.is_a?(InvoiceItem)
    assert_equal 10, invoice_items.first.id
    assert_equal "2012-03-27 14:54:09 UTC", invoice_items.first.created_at
  end

  def test_item_can_find_its_merchant
    item = items.find_by_id(1)
    merchant = item.merchant

    assert merchant.is_a?(Merchant)
  end


  # --------------------- Base Test Methods ----------------------------------
  def test_items_repository_exists
    assert items
  end

  def test_items_repository_contains_data
    assert_equal 103, items.all.length
  end

  def test_item_repository_returns_all_items
    assert_equal 103, items.all.length
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

# --------------------------- Find_by Test Methods -------------------------------
  def test_item_repository_returns_item_by_id
    by_id = items.find_by_id(5)
    assert_equal 68723, by_id.unit_price
    assert_equal "Item Expedita Aliquam", by_id.name
    assert_equal 1, by_id.merchant_id
    assert_equal "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", by_id.description
    assert by_id.is_a?(Item)
  end

  def test_item_repository_returns_item_by_name
    by_name = items.find_by_name("Item Provident At")
    assert_equal 6, by_name.id
    assert by_name.is_a?(Item)
  end

  def test_item_repositoyr_returns_item_by_description
    by_description = items.find_by_description("Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.")
    assert_equal 6, by_description.id
    assert by_description.is_a?(Item)

  end

  def test_item_repository_returns_item_by_unit_price
    by_unit_price = items.find_by_unit_price(15925)
    assert_equal 6, by_unit_price.id
    assert_equal "Item Provident At", by_unit_price.name
    assert_equal "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.", by_unit_price.description
    assert by_unit_price.is_a?(Item)
  end

  def test_item_repository_retuns_item_by_merchant_id
    by_merchant_id = items.find_by_merchant_id(1)
    assert_equal "Item Qui Esse", by_merchant_id.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", by_merchant_id.description
    assert by_merchant_id.is_a?(Item)
  end

  def test_item_repository_returns_item_by_created_at
    by_created_at = items.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, by_created_at.id
  end

  def test_item_repository_returns_items_by_updated_at
    by_updated_at = items.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, by_updated_at.id
  end

#----------- Find_by_all Test Methods ---------------------------
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
    assert_equal 103, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(Item)
  end
end
