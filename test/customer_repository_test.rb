require_relative 'test_helper'
#require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository, :engine

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    # @customer_repository = @engine.initialize_customer_repository
    @engine.initialize_customer_repository ############## do not delete
    @customer_repository = @engine.customer_repository ###### do not delete
  end

  # customer#items

  def test_it_finds_all_invoices_for_a_customer
    # custerom = single customer (in fixutres, make sure you know how many invoices they have)
    # invoices = customer.invoices
    # assert there are 8 invoices

    customer = customer_repository.find_by_id(1)
    binding.pry
    invoices = customer.invoices
    assert_equal 8, invoices.length
  end

  def test_customer_repository_exists
    assert customer_repository
  end

  def test_customer_repository_contains_data
    assert_equal 100,  customer_repository.all.length
  end

  def test_customer_repository_returns_all_customers
    assert_equal 100, engine.customer_repository.all.length
  end

  def test_customer_repository_returns_random_customer
    skip
    assert_equal "some_shit", engine.customer_repository.random
    #this is working but needs to have an array comparision written
  end

  def test_customer_repository_returns_customer_first_name_by_id
    by_id = engine.customer_repository.find_by_id(4)
    assert_equal "Leanne", by_id.first_name
  end

  def test_customer_repository_returns_customer_last_name_by_id
    by_id = engine.customer_repository.find_by_id(4)
    assert_equal "Braun", by_id.last_name
  end

  def test_customer_repository_returns_customer_by_first_name
    by_first_name = engine.customer_repository.find_by_first_name("Leanne")
    assert_equal 4, by_first_name.id
  end

  def test_customer_repository_returns_customer_by_last_name
    by_last_name = engine.customer_repository.find_by_last_name("Braun")
    assert_equal 4, by_last_name.id
  end

  def test_customer_repository_returns_customer_by_created_at
    by_created_at = engine.customer_repository.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_created_at.created_at
  end

  def test_customer_repository_returns_customer_by_updated_at
    by_updated_at = engine.customer_repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_updated_at.updated_at
  end

  def test_customer_repository_returns_all_by_id
    all_by_id = engine.customer_repository.find_all_by_id(4)
    assert_equal 1, all_by_id.count
  end

  def test_customer_repository_returns_all_by_first_name
    all_by_first_name = engine.customer_repository.find_all_by_first_name("Leanne")
    assert_equal 1, all_by_first_name.count
  end

  def test_customer_repository_returns_all_by_last_name
    all_by_last_name = engine.customer_repository.find_all_by_last_name("Braun")
    assert_equal 1, all_by_last_name.count
  end

  def test_customer_repository_returns_all_by_created_at
    all_by_created_at = engine.customer_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_created_at.count
  end

  def test_customer_repository_returns_all_by_updated_at
    all_by_updated_at = engine.customer_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, all_by_updated_at.count
  end


end
