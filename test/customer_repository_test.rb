require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @customers = engine.customer_repository
  end

  def test_customer_repository_exists
    assert customers
  end

  def test_customer_repository_contains_data
    assert_equal 100,  customers.all.length
  end

  def test_customer_repository_returns_all_customers
    assert_equal 100, customers.all.length
    assert customers.all.first.is_a?(Customer)
  end

  def test_customer_repository_returns_random_customer
    customer1, customer2 = customers.random, customers.random
    total_random_customers = 0
    until total_random_customers == 100
      total_random_customers += 1 if customer1 == customer2
      return total_random_customers
    end

    assert_equal 100, total_random_customers
    assert customer1.is_a?(Customer)
    assert customer2.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_first_name_by_id
    by_id = customers.find_by_id(4)
    assert_equal "Leanne", by_id.first_name
    assert_equal "Braun", by_id.last_name
    assert by_id.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_last_name_by_id
    by_id = customers.find_by_id(4)
    assert_equal "Braun", by_id.last_name
    assert_equal "Leanne", by_id.first_name
    assert by_id.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_by_first_name
    by_first_name = customers.find_by_first_name("Leanne")
    assert_equal 4, by_first_name.id
    assert_equal "Braun", by_first_name.last_name
    assert by_first_name.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_by_last_name
    by_last_name = customers.find_by_last_name("Braun")
    assert_equal 4, by_last_name.id
    assert_equal "Leanne", by_last_name.first_name
    assert by_last_name.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_by_created_at
    by_created_at = customers.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_created_at.created_at
    assert_equal 2, by_created_at.id
    assert_equal "Cecelia", by_created_at.first_name
    assert_equal "Osinski", by_created_at.last_name
    assert by_created_at.is_a?(Customer)
  end

  def test_customer_repository_returns_customer_by_updated_at
    by_updated_at = customers.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_updated_at.updated_at
    assert_equal 2, by_updated_at.id
    assert_equal "Cecelia", by_updated_at.first_name
    assert_equal "Osinski", by_updated_at.last_name
    assert by_updated_at.is_a?(Customer)
    assert_instance_of Customer, by_updated_at
  end

  def test_customer_repository_returns_all_by_id
    all_by_id = customers.find_all_by_id(4)
    assert_equal 1, all_by_id.count
    assert_equal "Leanne", all_by_id.first.first_name
    assert_equal "Braun", all_by_id.first.last_name
    assert all_by_id.first.is_a?(Customer)
  end

  def test_customer_repository_returns_all_by_first_name
    all_by_first_name = customers.find_all_by_first_name("Leanne")
    assert_equal 1, all_by_first_name.count
    assert_equal "Braun", all_by_first_name.first.last_name
    assert all_by_first_name.first.is_a?(Customer)
  end

  def test_customer_repository_returns_all_by_last_name
    all_by_last_name = customers.find_all_by_last_name("Braun")
    assert_equal 1, all_by_last_name.count
    assert_equal "Leanne", all_by_last_name.first.first_name
    assert all_by_last_name.first.is_a?(Customer)
  end

  def test_customer_repository_returns_all_by_created_at
    all_by_created_at = customers.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_created_at.count
    assert all_by_created_at.first.is_a?(Customer)
  end

  def test_customer_repository_returns_all_by_updated_at
    all_by_updated_at = customers.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(Customer)
  end

  def test_it_finds_all_invoices_for_a_customer
    customer = customers.find_by_id(1)
    invoices = customer.invoices

    assert invoices.is_a?(Array)
    assert_equal 8, invoices.size
  end

  def test_customer_transactions
    transactions = customers.find_invoices_by_(1)
    assert_equal 8, transactions.count
    assert_equal 1, transactions[0].id
    assert_equal 26, transactions[0].merchant_id
    assert_equal "shipped", transactions[0].status
    assert_equal "2012-03-25 09:54:09 UTC", transactions[0].updated_at
  end

  def test_favorite_merchant
    merchants = customers.find_favorite_merchant(26)
    assert_equal 26, merchants.id
    assert_equal "Balistreri, Schaefer and Kshlerin", merchants.name
    assert_equal "2012-03-27 14:54:01 UTC", merchants.created_at
    assert_equal "2012-03-27 14:54:01 UTC", merchants.updated_at
  end
end
