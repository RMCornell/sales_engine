require_relative 'test_helper'

class CustomerTest < Minitest::Test

  @@engine = SalesEngine.new('./data')
  #@@engine.startup
  @customer_data           = Parser.parse("./data/customers.csv")
  @customer_repository     = CustomerRepository.new(@customer_data, self)

  @@customers = @customer_repository

  def setup

  end


  def test_customers_can_exist
    assert @@customers
  end

  def test_customers_have_a_repository
    refute @@customers.any? { |customer| customer.repository.nil? }
  end

  def test_customers_have_an_id
    refute @@customers.any? { |customer| customer.id.nil? }
  end

  def test_customers_have_a_first_name
    refute @@customers.any? { |customer| customer.first_name.nil? }
  end

  def test_customers_have_a_last_name
    refute @@customers.any? { |customer| customer.last_name.nil? }
  end

  def test_customer_knows_when_it_was_created
    refute @@customers.any? { |customer| customer.created_at.nil? }
  end

  def test_customer_knows_when_it_was_last_modified
    refute @@customers.any? { |customer| customer.modified_at.nil? }
  end


end
