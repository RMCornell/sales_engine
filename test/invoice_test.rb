require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  
  def setup
    @engine = SalesEngine.new('./data')
    @engine.startup

    @invoice1 = @engine.invoice_repository.find_by_invoice_id(1)
    @invoices = @engine.invoice_repository
  end

  def test_invoice_can_find_its_customer
    assert_equal 'Joey', @invoice1.customer.first_name
  end


end
