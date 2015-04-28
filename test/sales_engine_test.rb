require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  # def test_sales_engine_exists?
  #   assert SalesEngine.new
  # end

  def test_sales_engine_has_a_customer_repository

    engine = SalesEngine.new('./data')
     engine.startup
     assert engine.customer_repository
  end
end
