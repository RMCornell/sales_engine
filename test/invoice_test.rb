require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository

    @invoice_id_1 = invoices.find_by_id(1)
  end

  def test_invoice_can_find_a_customers_invoices
    assert_equal 8, invoices.find_by_customer_id(1).length
  end

  def test_invoice_can_find_its_transaction
    @transaction = @invoice_id_1.created_at
    # todo pointless test
    assert_equal "2012-03-25 09:54:09 UTC", @transaction
  end
end
