require_relative 'test_helper'

class CustomerTest < Minitest::Test

  @@engine = SalesEngine.new('./data')
  @@engine.startup
  @@customers = @@engine.customer_repository

  def setup

  end


  def test_customers_can_exist
    assert @@customers
  end

  # def test_customers_have_a_unique_id(id)
  #
  # end

end
