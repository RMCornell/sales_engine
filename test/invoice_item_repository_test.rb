require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice_item = engine.invoice_item_repository
  end

  def test_invoice_item_can_find_its_invoice
    item = invoice_item.find_by_invoice_id(1)
    invoice_for_invoice_item_1 = item.invoice

    assert invoice_for_invoice_item_1.is_a?(Invoice)
    assert_equal 1, invoice_for_invoice_item_1.id
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice_for_invoice_item_1.created_at
  end

  def test_invoice_item_can_find_its_item
    item = invoice_item.find_by_invoice_id(1)
    instance_of_item = item.item
    assert instance_of_item.is_a?(Item)
    assert_equal 539, instance_of_item.id
    assert_equal "2012-03-27 14:54:01 UTC", instance_of_item.created_at
  end

  def test_invoice_item_repository_exists
    assert invoice_item
  end

  def test_invoice_item_repository_returns_all_invoice_items
    assert_equal 122, invoice_item.all.length
  end

  def test_invoice_item_repository_returns_random_invoice_item
    invoice_item1, invoice_item2 = invoice_item.random, invoice_item.random

    total_random_invoices = 0
    until total_random_invoices == 100
      total_random_invoices += 1 if invoice_item1 == invoice_item2
      return total_random_invoices
    end

    assert_equal 100, total_random_invoices
    assert invoice_item1.is_a?(InvoiceItem)
    assert invoice_item2.is_a?(InvoiceItem)
  end

  def test_invoice_item_repository_returns_invoice_items_by_id
    by_id = invoice_item.find_by_id(4)
    assert_equal 4, by_id.id
    assert_equal 535, by_id.item_id
    assert_equal 1, by_id.invoice_id
    assert_equal 2196, by_id.unit_price
    assert by_id.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_item_id
    by_item_id = invoice_item.find_by_id(4)
    assert_equal 535, by_item_id.item_id
    assert_equal 4, by_item_id.id
    assert_equal 1, by_item_id.invoice_id
    assert_equal 2196, by_item_id.unit_price
    assert by_item_id.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_invoice_id
    by_invoice_id = invoice_item.find_by_invoice_id(4)
    assert_equal 4, by_invoice_id.invoice_id
    assert_equal 680, by_invoice_id.item_id
    assert_equal 21, by_invoice_id.id
    assert_equal 42203, by_invoice_id.unit_price
    assert by_invoice_id.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_quantity
    by_quantity = invoice_item.find_by_quantity(5)
    assert_equal 5, by_quantity.quantity
    assert by_quantity.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_unit_price
    by_unit_price = invoice_item.find_by_unit_price(79140)
    assert_equal 7, by_unit_price.quantity
    assert by_unit_price.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_created_at
    by_created_at = invoice_item.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, by_created_at.id
    assert by_created_at.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_invoice_items_by_updated_at
    by_updated_at = invoice_item.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, by_updated_at.id
    assert by_updated_at.is_a?(InvoiceItem)
  end

  def test_invoice_repository_returns_all_invoice_items_by_id
    all_by_id = invoice_item.find_all_by_id(1)
    assert_equal 1, all_by_id.length
    assert all_by_id.first.is_a?(InvoiceItem)
  end

  def test_invoice_item_repository_returns_all_invoice_items_by_invoice_id
    all_by_invoice_id = invoice_item.find_all_by_invoice_id(5)
    assert_equal 4, all_by_invoice_id.length
    assert all_by_invoice_id.first.is_a?(InvoiceItem)
  end

  def test_invoice_items_repository_returns_all_invoice_items_by_quantity
    all_by_quantity = invoice_item.find_all_by_quantity(9)
    assert_equal 12, all_by_quantity.count
    assert all_by_quantity.first.is_a?(InvoiceItem)
  end

  def test_invoice_item_repository_returns_all_invoices_by_unit_price
    all_by_unit_price = invoice_item.find_all_by_unit_price(13635)
    assert_equal 1, all_by_unit_price.count
    assert all_by_unit_price.first.is_a?(InvoiceItem)
  end

  def test_invoice_item_repository_returns_all_invoices_by_created_at
    all_by_created_at = invoice_item.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, all_by_created_at.count
    assert all_by_created_at.first.is_a?(InvoiceItem)
  end

  def test_invoice_item_repository_returns_all_invoices_by_updated_at
    all_by_updated_at = invoice_item.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(InvoiceItem)
  end

  def test_invoice_items_have_an_id
    refute invoice_item.invoice_items.any? { |invoice_item| invoice_item.id.nil? }
  end

  def test_invoice_items_have_an_item_id
    refute invoice_item.invoice_items.any? { |invoice_item| invoice_item.item_id.nil? }
  end

  def test_invoice_items_have_an_invoice_id
    refute invoice_item.invoice_items.any? { |invoice_item| invoice_item.invoice_id.nil? }
  end

  def test_invoice_item_knows_when_it_was_created
     refute invoice_item.invoice_items.any? { |invoice_item| invoice_item.created_at.nil? }
  end

  def test_invoice_item_knows_when_it_was_updated
    refute invoice_item.invoice_items.any? { |invoice_item| invoice_item.updated_at.nil? }
  end
end
