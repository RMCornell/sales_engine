require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists?
    assert SalesEngine.new
  end

  def test_sales_engine_can_startup
    engine = SalesEngine.new
    assert engine.startup
  end
end
