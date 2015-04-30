require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  
  def setup
    @engine = SalesEngine.new('./data')
    @engine.startup

    @invoice1 = @engine.invoice_repository.find_by_invoice_id(1)
    @invoices = @engine.invoice_repository
    @transaction = @engine.transaction_repository.find_by_invoice_id(1)
  end

  def test_invoice_can_find_its_customer
    assert_equal 'Joey', @invoice1.customer.first_name
  end

  def test_invoice_can_find_its_transaction
    @transaction = @invoice1.transactions
    assert_equal '2012-03-27 14:54:09 UTC', @transaction.created_at
  end
end
