require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures') ### correct
    engine.initialize_invoice_repository ### correct
    @invoices = engine.invoice_repository ## correct

    @invoice_id_1 = @invoices.find_by_invoice_id(1)
  end

  def test_invoice_can_find_its_customer

    assert_equal 'Joey', invoices.find_by_customer_id(1)
  end

  def test_invoice_can_find_its_transaction
    @transaction = @invoice_id_1.created_at
    # todo pointless test
    assert_equal "2012-03-25 09:54:09 UTC", @transaction
  end
end
