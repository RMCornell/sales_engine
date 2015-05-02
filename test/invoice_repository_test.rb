require_relative 'test_helper'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository
  end

  #-------------------- Relationship Method Tests --------------------


  def test_invoice_has_successful_transactions # invoice#transactions
    invoice = invoices.find_by_id(5)
    invoice_transactions = invoice.transactions

    assert_equal 4, invoice_transactions.id
    assert_equal "2012-03-27 14:54:10 UTC", invoice_transactions.created_at
    assert_equal 'success', invoice_transactions.result
  end

  def test_invoice_can_have_unsuccessful_transactions
    invoice = invoices.find_by_id(12)
    invoice_transactions = invoice.transactions

    assert_equal 11, invoice_transactions.id
    assert_equal "2012-03-27 14:54:10 UTC", invoice_transactions.created_at
    assert_equal 'failed', invoice_transactions.result
  end

  def test_invoice_has_invoice_items # invoice#invoice_items
    invoice = invoices.find_by_id(5)
    invoice_items = invoice.invoice_items

    assert invoice_items.is_a?(InvoiceItem)
    assert_equal 5, invoice_items.invoice_id
    assert_equal 23, invoice_items.id
    assert_equal 932, invoice_items.item_id
    assert_equal "2012-03-27 14:54:10 UTC", invoice_items.created_at
  end

  def test_invoice_can_display_its_items # invoice#items
    # items returns a collection of associated Items by way of InvoiceItem objects
    invoice = invoices.find_by_id(5)
    items = invoice.items

    assert items.is_a?(Item)
    assert_equal 932, items.id
    assert_equal 41, items.merchant_id
    assert_equal "2012-03-27 14:54:03 UTC", items.created_at
  end

  def test_invoice_has_a_customer # invoice#customer
    invoice = invoices.find_by_id(5)
    customer_invoice = invoice.customer

    assert_equal "Sylvester", customer_invoice.first_name
    assert_equal "Nader", customer_invoice.last_name
  end

  def test_invoice_has_a_merchant # invoice#merchant
    invoice = invoices.find_by_id(5)
    merchant = invoice.merchant

    assert merchant.is_a?(Merchant)
    assert_equal 41, merchant.id
    assert_equal "2012-03-27 14:54:03 UTC", merchant.created_at
  end


  #-------------------- Base Method Tests --------------------
  def test_invoices_can_exist
    assert invoices
  end

  def test_invoices_contain_data
    assert_equal 100, invoices.all.length
  end

  def test_invoice_repository_returns_all_invoices
    assert_equal 100, invoices.all.length
  end

  def test_invoice_repository_returns_random_invoice
    invoice1, invoice2 = invoices.random, invoices.random

    total_random_invoices = 0
    until total_random_invoices == 100
      total_random_invoices += 1 if invoice1 == invoice2
      return total_random_invoices
    end

    assert_equal 100, total_random_invoices
  end

#-------------------- Find_by Method Tests --------------------
  def test_invoice_repository_returns_invoices_by_id
    by_id = invoices.find_by_id(4)
    assert_equal 4, by_id.id
  end

  def test_invoice_repository_returns_invoices_by_customer_id
    by_customer_id = invoices.find_by_customer_id(4)
    assert_equal 4, by_customer_id.customer_id
  end

  def test_invoice_repository_returns_invoices_by_merchant_id
    by_merchant_id = invoices.find_by_merchant_id(96)
    assert_equal 9, by_merchant_id.customer_id
  end

  def test_invoice_repository_returns_invoices_by_status
    by_status = invoices.find_by_status("shipped")
    assert_equal 1, by_status.id
  end

  def test_invoice_repository_returns_invoices_by_created_at
    by_created_at = invoices.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, by_created_at.customer_id
  end

  def test_invoice_repository_returns_invoices_by_updated_at
    by_updated_at = invoices.find_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, by_updated_at.customer_id
  end

#-------------------- Find_all_by Method Tests --------------------
  def test_invoice_repository_returns_all_invoices_by_id
    all_by_id = invoices.find_all_by_id(1)
    assert_equal 1, all_by_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_customer_id
    all_by_customer_id = invoices.find_all_by_customer_id(4)
    assert_equal 8, all_by_customer_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_merchant_id
    all_by_merchant_id = invoices.find_all_by_merchant_id(86)
    assert_equal 3, all_by_merchant_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_status
    all_by_status = invoices.find_all_by_status("shipped")
    assert_equal 100, all_by_status.count
  end

  def test_invoice_repository_returns_all_by_created_at
    all_by_created_at = invoices.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, all_by_created_at.count
  end

  def test_invoice_repository_returns_all_by_updated_at
    all_by_updated_at = invoices.find_all_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, all_by_updated_at.count
  end

  def test_invoices_have_a_repository
    assert invoices
  end

  def test_invoices_have_an_id
    refute invoices.any? { |invoice| invoice.id.nil? }
  end

  def test_invoices_have_a_customer_id
    refute invoices.any? { |invoice| invoice.customer_id.nil? }
  end

  def test_invoices_have_a_merchant_id
    refute invoices.any? { |invoice| invoice.merchant_id.nil? }
  end

  def test_invoice_has_a_status
    refute invoices.any? { |invoice| invoice.status.nil? }
  end

  def test_invoice_knows_when_it_was_created
    refute invoices.any? { |invoice| invoice.created_at.nil? }
  end

  def test_invoice_knows_when_it_was_updated
    refute invoices.any? { |invoice| invoice.updated_at.nil? }
  end


end


