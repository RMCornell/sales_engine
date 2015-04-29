require_relative 'test_helper'

class CustomerTest < Minitest::Test

  def setup
    @engine = SalesEngine.new('./data')
    @customer1 = @engine.customer_repository.find_customer_by_id(1)
    @customers = @engine.customer_repository
  end

  def test_customers_can_exist
    assert @customers
  end

  def test_customers_have_a_repository
    refute @customers.any? { |customer| customer.repository.nil? }
  end

  def test_customers_have_an_id
    refute @customers.any? { |customer| customer.id.nil? }
  end

  def test_customers_have_a_first_name
    refute @customers.any? { |customer| customer.first_name.nil? }
  end

  def test_customers_have_a_last_name
    refute @customers.any? { |customer| customer.last_name.nil? }
  end

  def test_customer_knows_when_it_was_created
    refute @customers.any? { |customer| customer.created_at.nil? }
  end

  def test_customers_can_exist
    assert @@customers
  end

  def test_customer_knows_when_it_was_last_modified
    # todo need these probably set to 'created_at'
    refute @customers.any? { |customer| customer.updated_at.nil? }
  end

  def test_find_invoices_by_customer
    binding.pry
    assert_equal 8, @customer1.invoices
    puts 'asdf'
  end
end
