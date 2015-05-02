require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository

    @invoice_id_1 = invoices.find_by_id(1)
  end





end
