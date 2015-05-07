require_relative 'test_helper'

class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new('./data')
    engine.startup
  end

  def test_sales_engine_can_start_up_its_repositories
    assert engine.customer_repository
    assert engine.invoice_repository
    assert engine.transaction_repository
    assert engine.merchant_repository
    assert engine.item_repository
    assert engine.invoice_item_repository
  end

  def test_merchant_can_calculate_total_revenue
    merchant = engine.merchant_repository.find_by_id(62)
    assert_equal "0.58011587E6", merchant.revenue.to_s
  end

  def test_merchant_can_calculate_total_revenue_by_date
     merchant = engine.merchant_repository.find_by_id(3)
     date = Date.parse("Fri, 09 Mar 2012")
     merchant.revenue(date)
     BigDecimal.new("8373.29")
    assert_equal BigDecimal.new("8373.29"), merchant.revenue(date)
  end

  def test_find_customers_with_pending_invoices_for_a_merchant
    merchant = engine.merchant_repository.find_by_id(57)
    assert_equal 4, merchant.customers_with_pending_invoices.size
  end
end

