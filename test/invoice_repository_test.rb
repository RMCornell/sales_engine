require_relative 'test_helper'
require 'minitest/autorun'


class InvoiceRepositoryTest < Minitest::Test
  @@engine = SalesEngine.new('/data')
  @invoice_data = Parser.parse('./data/invoices.csv')
  @invoice_repository = InvoiceRepository.new(@invoice_data, self)

  @@invoices = @invoice_repository

  def test_invoices_can_exist
    assert @@invoices
  end

  def test_invoices_have_a_repository

    assert @@invoices
  end

  def test_invoices_have_an_id
    refute @@invoices.invoice.any? { |invoice| invoice.id.nil? }
  end

  def test_invoices_have_a_customer_id
    refute @@invoices.invoice.any? { |invoice| invoice.customer_id.nil? }
  end

  def test_invoices_have_a_merchant_id
    refute @@invoices.invoice.any? { |invoice| invoice.merchant_id.nil? }
  end

  def test_invoice_has_a_status
    refute @@invoices.invoice.any? { |invoice| invoice.status.nil? }
  end

  def test_invoice_knows_when_it_was_created
    refute @@invoices.invoice.any? { |invoice| invoice.created_at.nil? }
  end

  def test_invoice_knows_when_it_was_updated
    refute @@invoices.invoice.any? { |invoice| invoice.updated_at.nil? }
  end

end


