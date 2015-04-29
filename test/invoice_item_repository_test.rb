require_relative 'test_helper'
require 'minitest/autorun'


class InvoiceRepositoryTest < Minitest::Test
  @@engine            = SalesEngine.new('/data')
  @invoice_item_data       = Parser.parse('./data/invoice_items.csv')
  @invoice_item_repository = InvoiceItemRepository.new(@invoice_item_data, self)

  @@invoice_items = @invoice_item_repository

  def test_invoices_can_exist
    assert @@invoice_items
  end

  def test_invoices_have_a_repository

    assert @@invoice_items
  end

  def test_invoices_have_an_id

    refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.id.nil? }
  end


  def test_invoices_have_an_item_id
    refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.item_id.nil? }
  end

  def test_invoices_have_an_invoice_id
    refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.invoice_id.nil? }
  end

  def test_invoice_has_a_quantity
    refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.quantity.nil? }
  end

  def test_invoice_knows_when_it_was_created
     refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.created_at.nil? }
  end

  def test_invoice_knows_when_it_was_updated
    refute @@invoice_items.invoice_item.any? { |invoice_item| invoice_item.updated_at.nil? }
  end

end