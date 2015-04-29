require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

    # todo bad practice?
    # 7.95 to 1.68 seconds

    @@engine = SalesEngine.new('./data')
    @@engine.startup

  # def setup
  #   @engine = SalesEngine.new('./data')
  #   @engine.startup unless @engine.startup
  #  end

  def test_sales_engine_exists?
    assert @@engine
  end

  def test_sales_engine_has_a_customer_repository
    assert @@engine.customer_repository
  end

  def test_sales_engine_has_an_invoice_repository
    assert @@engine.invoice_repository
  end

  def test_sales_engine_has_a_transaction_repository
    assert @@engine.transaction_repository
  end

  def test_sales_engine_has_a_merchant_repository
    assert @@engine.merchant_repository
  end

  def test_sales_engine_has_an_items_repository
    assert @@engine.item_repository
  end

  def test_sales_engine_has_an_invoice_items_repository
    assert @@engine.invoice_item_repository
  end
end
