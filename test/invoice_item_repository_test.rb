require_relative 'test_helper'
require 'minitest/autorun'


class InvoiceItemsRepositoryTest < Minitest::Test

  def setup
    @engine = SalesEngine.new('./data')
    @engine.startup
    @invoice_items = @engine.invoice_item_repository
  end

  def test_invoice_items_can_exist
    assert @invoice_items
  end

  def test_invoice_items_have_a_repository
    assert @invoice_items
  end

  # def test_invoice_items_have_an_id
  #   refute @invoice_items.any? { |invoice_item| invoice_item.id.nil? }
  # end
  #
  # def test_invoice_items_have_an_item_id
  #   refute @invoice_items.any? { |invoice_item| invoice_item.item_id.nil? }
  # end
  #
  # def test_invoice_items_have_an_invoice_id
  #   refute @invoice_items.any? { |invoice_item| invoice_item.invoice_id.nil? }
  # end
  #
  # def test_invoice_item_knows_when_it_was_created
  #    refute @invoice_items.any? { |invoice_item| invoice_item.created_at.nil? }
  # end
  #
  # def test_invoice_item_knows_when_it_was_updated
  #   refute @invoice_items.any? { |invoice_item| invoice_item.updated_at.nil? }
  # end

end
