require_relative 'test_helper'



class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_items, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoice_items = engine.invoice_item_repository
  end

  def test_invoice_items_have_item_names
    #invoice = engine.invoice_repository.find_by_id(1002)
    #items = invoice.invoice_items


    #items = items.map { |item| engine.item_repository.find_by_id(item.item_id) }
    #invoice_item_names = items.map { |item| item.name }



     invoice = engine.invoice_repository.find_by_id(1002)
     invoice_item_names = invoice.invoice_items.map { |ii| ii.item.name }

    assert invoice_item_names.include?('Item Accusamus Officia')
  end
end
