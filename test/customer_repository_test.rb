require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @customers = engine.customer_repository
  end

  # customer#items

  def test_it_finds_all_invoices_for_a_customer
    customer = customers.find_by_id(1)
    invoices = customer.invoices
    assert_equal 8, invoices.length
  end

  def test_customer_repository_exists
    assert customers
  end

  def test_customer_repository_contains_data
    assert_equal 100,  customers.all.length
  end

  def test_customer_repository_returns_all_customers
    assert_equal 100, customers.all.length
  end

  def test_customer_repository_returns_random_customer

    customer1, customer2 = customers.random, customers.random

    total_random_customers = 0
    until total_random_customers == 100
      total_random_customers += 1 if customer1 == customer2
      return total_random_customers
    end

    assert_equal 100, total_random_customers
  end

  def test_customer_repository_returns_customer_first_name_by_id
    by_id = customers.find_by_id(4)
    assert_equal "Leanne", by_id.first_name
  end

  def test_customer_repository_returns_customer_last_name_by_id
    by_id = customers.find_by_id(4)
    assert_equal "Braun", by_id.last_name
  end

  def test_customer_repository_returns_customer_by_first_name
    by_first_name = customers.find_by_first_name("Leanne")
    assert_equal 4, by_first_name.id
  end

  def test_customer_repository_returns_customer_by_last_name
    by_last_name = customers.find_by_last_name("Braun")
    assert_equal 4, by_last_name.id
  end

  def test_customer_repository_returns_customer_by_created_at
    by_created_at = customers.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_created_at.created_at
  end

  def test_customer_repository_returns_customer_by_updated_at
    by_updated_at = customers.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_updated_at.updated_at
  end

  def test_customer_repository_returns_all_by_id
    all_by_id = customers.find_all_by_id(4)
    assert_equal 1, all_by_id.count
  end

  def test_customer_repository_returns_all_by_first_name
    all_by_first_name = customers.find_all_by_first_name("Leanne")
    assert_equal 1, all_by_first_name.count
  end

  def test_customer_repository_returns_all_by_last_name
    all_by_last_name = customers.find_all_by_last_name("Braun")
    assert_equal 1, all_by_last_name.count
  end

  def test_customer_repository_returns_all_by_created_at
    all_by_created_at = customers.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_created_at.count
  end

  def test_customer_repository_returns_all_by_updated_at
    all_by_updated_at = customers.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_updated_at.count
  end
end
