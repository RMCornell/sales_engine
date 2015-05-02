require_relative 'test_helper'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository
  end

  def test_invoices_can_exist
    assert invoices
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

  # //---------- Invoice relationship tests -------------------------------------------//

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
#<Item: id:932 name: "Item Non Necessitatibus" unit_price: 66412 merchant_id: 41
# created_at: "2012-03-27 14:54:03 UTC" updated_at: "2012-03-27 14:54:03 UTC">
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

  end

  # -------------------------- end relationship tests
end


