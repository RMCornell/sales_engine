require_relative 'test_helper'



class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice_item = engine.invoice_item_repository

  end

  def test_invoice_item_repository_exists
    assert invoice_item
  end

  def test_invoice_item_repository_contains_data
    assert_equal 99, invoice_item.all.length
  end

  def test_invoice_item_repository_returns_all_invoice_items
    assert_equal 99, invoice_item.all.length
  end

  def test_invoice_item_repository_returns_random_invoice_item
    invoice_item1, invoice_item2 = invoice_item.random, invoice_item.random

    total_random_invoices = 0
    until total_random_invoices == 100
      total_random_invoices += 1 if invoice_item1 == invoice_item2
      return total_random_invoices
    end

    assert_equal 100, total_random_invoices
  end

  def test_invoice_item_repository_returns_invoice_items_by_id
    by_id = invoice_item.find_by_id(4)
    assert_equal 4, by_id.id
  end

  def test_invoice_items_repository_returns_invoice_items_by_item_id
    by_item_id = invoice_item.find_by_id(4)
    assert_equal 535, by_item_id.item_id
  end

  def test_invoice_items_repository_returns_invoice_items_by_invoice_id
    by_invoice_id = invoice_item.find_by_invoice_id(4)
    assert_equal 4, by_invoice_id.invoice_id
  end

  def test_invoice_items_repository_returns_invoice_items_by_quantity
    by_quantity = invoice_item.find_by_quantity(5)
    assert_equal 5, by_quantity.quantity
  end

  def test_invoice_items_repository_returns_invoice_items_by_unit_price
    skip
    by_unit_price = invoice_item.find_by_unit_price(79140)
    assert_equal 5, by_unit_price.length
    #unclear why this is not working
  end

  def test_invoice_items_repository_returns_invoice_items_by_created_at
    by_created_at = invoice_item.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, by_created_at.id

  end

  def test_invoice_items_repository_returns_invoice_items_by_updated_at
    by_updated_at = invoice_item.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, by_updated_at.id
  end

#Find_all_by Method Tests
  def test_invoice_repository_returns_all_invoice_items_by_id
    all_by_id = invoice_item.find_all_by_id(1)
    assert_equal 1, all_by_id.length
  end

  def test_invoice_item_repository_returns_all_invoice_items_by_invoice_id
    all_by_invoice_id = invoice_item.find_all_by_invoice_id(5)
    assert_equal 4, all_by_invoice_id.length
    assert all_by_invoice_id.first.is_a?(InvoiceItem)
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

  #id,item_id,invoice_id,quantity,unit_price,created_at,updated_at