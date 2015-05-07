require_relative 'test_helper'

class CustomerTest < Minitest::Test
  attr_reader :engine, :customers, :customer

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @customers = engine.customer_repository
    @customer = engine.customer_repository.find_by_id(2)
  end

  def test_customers_have_a_repository
    refute customers.any? { |customer| customer.repository.nil? }
  end

  def test_customers_attributes_are_not_nil
    refute customers.any? { |customer| customer.id.nil? }
    refute customers.any? { |customer| customer.first_name.nil? }
    refute customers.any? { |customer| customer.last_name.nil? }
    refute customers.any? { |customer| customer.created_at.nil? }
    refute customers.any? { |customer| customer.updated_at.nil? }
  end

  def test_can_return_customer_invoices
    assert_equal 1, customer.invoices.size
  end

  def test_customer_transactions
    assert_equal 1, customer.transactions.size
  end

  def test_customer_finds_favorite_merchant
    assert_equal "Shields, Hirthe and Smith", customer.favorite_merchant.name
  end
end
