require_relative 'test_helper'

class ItemTest < Minitest::Test
  attr_reader :engine, :items

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @items = engine.item_repository
    @item1 = items.find_by_id(1)
    @item2 = engine.item_repository.find_by_name("Item Saepe Ipsum")
  end

  def test_it_can_find_its_invoice_items
    assert_equal 8, @item2.invoice_items.size

    @item2.invoice_items.each do |ii|
      assert_equal @item2.id, ii.item_id
    end
  end

  def test_item_knows_who_its_merchant_is
    assert_equal "Kilback Inc", @item2.merchant.name
  end
end

