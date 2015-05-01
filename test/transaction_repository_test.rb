require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :engine, :transactions

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @transactions = engine.transaction_repository
  end


  # transactions#invoice

  def test_transactions_can_find_their_invoice
    transaction = transactions.find_by_id(1)
    invoice = transaction.invoice.id

    assert_equal 1, invoice
  end

  # # customer#items
  #
  # def test_it_finds_all_invoices_for_a_customer
  #   customer = customer_repository.find_by_id(1)
  #   invoices = customer.invoices
  #   assert_equal 8, invoices.length
  # end





  # Basic SetUp Tests

  def test_transaction_repository_exists
    assert transactions
  end

  def test_transaction_repository_contatins_data
    assert_equal 99, transactions.all.length
  end

#Find_by Method Tests
  def test_transaction_repository_returns_all_transactions
    assert_equal 99, engine.transaction_repository.all.length
  end

  def test_transaction_repository_returns_random_transaction
    skip
    assert_equal "some random shit", transactions.random
    #This works in practice but needs a better test to test it.
  end

  def test_transaction_repository_returns_transaction_by_id
    by_id = engine.transaction_repository.find_by_id(4)
    assert_equal 5, by_id.invoice_id
  end

  def test_transaction_repository_returns_transaction_by_invoice_id
    by_invoice_id = engine.transaction_repository.find_by_invoice_id(5)
    assert_equal 4, by_invoice_id.id
  end

  def test_transaction_repository_returns_transaction_by_credit_card_number
    by_credit_card_number = engine.transaction_repository.find_by_credit_card_number("4354495077693036")
    assert_equal 4, by_credit_card_number.invoice_id
  end

  def test_transaction_repository_returns_transactions_credit_card_expiration_date
    skip
    #This value is nil throughout the database
  end

  def test_transaction_repository_returns_transactions_by_result
    by_result = engine.transaction_repository.find_by_result("success")
    assert_equal "success", by_result.result
  end

  def test_transaction_repository_returns_transactions_by_created_at
    by_created_at = engine.transaction_repository.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_created_at.created_at
  end

  def test_transaction_repository_returns_transactions_by_updated_at
    by_updated_at = engine.transaction_repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_updated_at.updated_at
  end

#Find_by_all Method Tests
  def test_transaction_repository_finds_all_by_id
    all_by_id = engine.transaction_repository.find_all_by_id(4)
    assert_equal 1, all_by_id.count
  end

  def test_transaction_repository_finds_all_by_invoice_id
    all_by_invoice_id = engine.transaction_repository.find_all_by_invoice_id(5)
    assert_equal 1, all_by_invoice_id.count
  end

  def test_transaction_repository_finds_all_by_credit_card_number
    all_by_credit_card_number = engine.transaction_repository.find_all_by_credit_card_number("4354495077693036")
    assert_equal 1, all_by_credit_card_number.count
  end

  def test_transaction_repository_finds_all_by_result_success
    all_by_result = engine.transaction_repository.find_all_by_result("success")
    assert_equal 83, all_by_result.count
  end

  def test_transaction_repository_finds_all_by_result_failed
    all_by_result = engine.transaction_repository.find_all_by_result("failed")
    assert_equal 16, all_by_result.count
  end

  def test_transaction_repository_finds_all_by_created_at
    all_by_created_at = engine.transaction_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 20, all_by_created_at.count
  end

  def test_transaction_repository_finds_all_by_updated_at
    all_by_updated_at = engine.transaction_repository.find_all_by_updated_at ("2012-03-27 14:54:10 UTC")
    assert_equal 20, all_by_updated_at.count
  end
end
