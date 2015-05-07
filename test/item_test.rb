require_relative 'test_helper'

class ItemTest < Minitest::Test
  attr_reader :engine, :item_repository

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @item_repository = engine.item_repository

    @item = item_repository.find_by_id(1)
  end

  def test_it_can_find_the_quantity_sold
    skip
    assert_equal 19, @item.quantity_sold
  end
end

