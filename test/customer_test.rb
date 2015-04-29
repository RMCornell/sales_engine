require_relative 'test_helper'

class CustomerTest < Minitest::Test

  @@engine = SalesEngine.new('./data')
  @@engine.startup
  @customer_data           = Parser.parse("./data/customers.csv")
  @customer_repository     = CustomerRepository.new(@customer_data, self)


  @@customers = @customer_repository

  def setup

  end


  def test_customers_can_exist

    assert @@customers
  end

  def test_customers_have_an_id
    #@@customers { |customer| customer.id.nil? }
  end

end
