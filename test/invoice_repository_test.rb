require_relative 'test_helper'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository
  end

  def test_invoice_has_successful_transactions
    invoice = invoices.find_by_id(5)
    invoice_transactions = invoice.transactions

    refute invoice_transactions.empty? , invoice_transactions
    assert_equal "2012-03-27 14:54:10 UTC", invoice_transactions[0].created_at
    assert_equal 'success', invoice_transactions[0].result
  end

  def test_invoice_can_have_unsuccessful_transactions
    invoice = invoices.find_by_id(12)
    invoice_transactions = invoice.transactions

    assert_equal 'failed', invoice_transactions.first.result
    assert_equal "2012-03-27 14:54:10 UTC", invoice_transactions.first.created_at
  end

  def test_invoice_has_invoice_items
    invoice = invoices.find_by_id(5)
    invoice_items = invoice.invoice_items

    assert invoice_items.is_a?(Array)
    assert_equal 4, invoice_items.size
    assert_equal "2012-03-27 14:54:10 UTC", invoice_items.first.created_at
  end

  def test_invoice_can_display_its_items
    invoice = invoices.find_by_id(5)
    items = invoice.items

    assert items.is_a?(Array)
    assert_equal 4, items.size
    assert_equal "2012-03-27 14:54:03 UTC", items.first.created_at
  end

  def test_invoice_has_a_customer
    invoice = invoices.find_by_id(5)
    customer_invoice = invoice.customer

    assert_equal "Joey", customer_invoice.first_name
    assert_equal "Ondricka", customer_invoice.last_name
  end

  def test_invoice_has_a_merchant
    invoice = invoices.find_by_id(5)
    merchant = invoice.merchant

    assert merchant.is_a?(Merchant)
    assert_equal 41, merchant.id
    assert_equal "2012-03-27 14:54:03 UTC", merchant.created_at
  end

  def test_invoices_can_exist
    assert invoices
  end

  def test_invoices_contain_data
    assert_equal 102, invoices.all.length
  end

  def test_invoice_repository_returns_all_invoices
    assert_equal 102, invoices.all.length
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

  def test_invoice_repository_returns_invoices_by_id
    by_id = invoices.find_by_id(4)
    assert_equal 1, by_id.customer_id
    assert_equal 4, by_id.id
    assert_equal 33, by_id.merchant_id
    assert_equal "shipped", by_id.status
    assert by_id.is_a?(Invoice)
  end

  def test_invoice_repository_returns_invoices_by_customer_id
    by_customer_id = invoices.find_by_customer_id(4)
    assert_equal 4, by_customer_id.customer_id
    assert_equal 44, by_customer_id.merchant_id
    assert_equal "shipped", by_customer_id.status
    assert by_customer_id.is_a?(Invoice)
  end

  def test_invoice_repository_returns_invoices_by_merchant_id
    by_merchant_id = invoices.find_by_merchant_id(96)
    assert_equal 9, by_merchant_id.customer_id
    assert_equal "shipped", by_merchant_id.status
    assert by_merchant_id.is_a?(Invoice)
  end

  def test_invoice_repository_returns_invoices_by_status
    by_status = invoices.find_by_status("shipped")
    assert_equal 1, by_status.id
    assert by_status.is_a?(Invoice)
  end

  def test_invoice_repository_returns_invoices_by_created_at
    by_created_at = invoices.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))
    assert_equal 1, by_created_at.customer_id
    assert by_created_at.is_a?(Invoice)
  end

  def test_invoice_repository_returns_invoices_by_updated_at
    by_updated_at = invoices.find_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, by_updated_at.customer_id
    assert by_updated_at.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_invoices_by_id
    all_by_id = invoices.find_all_by_id(1)
    assert_equal 1, all_by_id.count
    assert all_by_id.first.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_invoices_by_customer_id
    all_by_customer_id = invoices.find_all_by_customer_id(4)
    assert_equal 8, all_by_customer_id.count
    assert all_by_customer_id.first.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_invoices_by_merchant_id
    all_by_merchant_id = invoices.find_all_by_merchant_id(86)
    assert_equal 3, all_by_merchant_id.count
    assert all_by_merchant_id.first.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_invoices_by_status
    all_by_status = invoices.find_all_by_status("shipped")
    assert_equal 102, all_by_status.count
    assert all_by_status.first.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_by_created_at
    all_by_created_at =
      invoices.find_all_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))
    assert_equal 5, all_by_created_at.count
    assert all_by_created_at.first.is_a?(Invoice)
  end

  def test_invoice_repository_returns_all_by_updated_at
    all_by_updated_at = invoices.find_all_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(Invoice)
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

  def test_unpaid_invoices
    assert engine.invoice_repository.unpaid_invoices
    assert engine.invoice_repository.unpaid_invoices.all? { |invoice|
             invoice.transactions.all? { |result| result.result == 'failed' } }
  end

  def test_paid_invoices
    assert engine.invoice_repository.paid_invoices
    assert engine.invoice_repository.paid_invoices.all? { |invoice|
             invoice.transactions.one? { |result| result.result == 'success' } }
  end
end


