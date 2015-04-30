require_relative 'test_helper'
require 'minitest/autorun'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    @engine = SalesEngine.new('./data')
    @engine.startup
    @invoice_repository = @engine.invoice_repository
  end

  def test_invoices_can_exist
    assert @invoice_repository
  end

  def test_invoices_have_a_repository
    assert @invoice_repository
  end

  def test_invoices_have_an_id
    refute @invoice_repository.invoices.any? { |invoice| invoice.id.nil? }
  end

  def test_invoices_have_a_customer_id
    refute @invoice_repository.invoices.any? { |invoice| invoice.customer_id.nil? }
  end

  def test_invoices_have_a_merchant_id
    refute @invoice_repository.invoices.any? { |invoice| invoice.merchant_id.nil? }
  end

  def test_invoice_has_a_status
    refute @invoice_repository.invoices.any? { |invoice| invoice.status.nil? }
  end

  def test_invoice_knows_when_it_was_created
    refute @invoice_repository.invoices.any? { |invoice| invoice.created_at.nil? }
  end

  def test_invoice_knows_when_it_was_updated
    refute @invoice_repository.invoices.any? { |invoice| invoice.updated_at.nil? }
  end

end


