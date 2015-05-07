require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository
    @invoice_id_1 = invoices.find_by_id(1)
  end

  def test_spec_harness_invoice_test
    invoice = engine.invoice_repository.find_by_id(1002)
    item = invoice.items.find {|i| i.name == 'Item Accusamus Officia' }

    assert_equal 3, invoice.items.size
    assert item
  end
end
