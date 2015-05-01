require_relative 'test_helper'


class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :engine, :invoice_items_repository

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice_items_repository = engine.invoice_item_repository
  end

  def test_invoice_items_can_exist
    assert invoice_items_repository
  end

  def test_invoice_items_have_a_repository
    assert invoice_items_repository
  end

  def test_invoice_items_have_an_id
    refute invoice_items_repository.invoice_items.any? { |invoice_item| invoice_item.id.nil? }
  end

  def test_invoice_items_have_an_item_id
    refute invoice_items_repository.invoice_items.any? { |invoice_item| invoice_item.item_id.nil? }
  end

  def test_invoice_items_have_an_invoice_id
    refute invoice_items_repository.invoice_items.any? { |invoice_item| invoice_item.invoice_id.nil? }
  end

  def test_invoice_item_knows_when_it_was_created
     refute invoice_items_repository.invoice_items.any? { |invoice_item| invoice_item.created_at.nil? }
  end

  def test_invoice_item_knows_when_it_was_updated
    refute invoice_items_repository.invoice_items.any? { |invoice_item| invoice_item.updated_at.nil? }
  end

end
