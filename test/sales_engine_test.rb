require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists?
    assert SalesEngine.new('./data')
  end

  def test_sales_engine_has_a_customer_repository
    dir = './data'
    customer_data = Parser.parse("#{dir}/customers.csv")
    customer_repository = CustomerRepository.new(customer_data, self)

    engine = SalesEngine.new('./data')
    engine.startup

    assert engine.customer_repository
  end
end
