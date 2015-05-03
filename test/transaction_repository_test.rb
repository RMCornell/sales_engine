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
    assert_equal 99, transactions.all.length
  end

  def test_transaction_repository_returns_random_transaction

    transaction1, transaction2 = transactions.random, transactions.random

    total_random_transactions = 0
    until total_random_transactions == 100
      total_random_transactions += 1 if transaction1 == transaction2
      return total_random_transactions
    end

    assert_equal 500, total_random_transactions
    assert transaction1.is_a?(Transaction)
    assert transaction2.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transaction_by_id
    by_id = transactions.find_by_id(4)
    assert_equal 5, by_id.invoice_id
    assert_equal "4515551623735607", by_id.credit_card_number
    assert_equal "success", by_id.result
    assert by_id.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transaction_by_invoice_id
    by_invoice_id = transactions.find_by_invoice_id(5)
    assert_equal 4, by_invoice_id.id
    assert_equal "4515551623735607", by_invoice_id.credit_card_number
    assert_equal "success", by_invoice_id.result
    assert by_invoice_id.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transaction_by_credit_card_number
    by_credit_card_number = transactions.find_by_credit_card_number("4354495077693036")
    assert_equal 4, by_credit_card_number.invoice_id
    assert_equal 3, by_credit_card_number.id
    assert_equal "success", by_credit_card_number.result
    assert by_credit_card_number.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transactions_credit_card_expiration_date
    check_expiration_date = transactions.find_by_credit_card_expiration_date(5)
    assert check_expiration_date.nil?
  end

  def test_transaction_repository_returns_transactions_by_result
    by_result = transactions.find_by_result("success")
    assert_equal "success", by_result.result
    assert by_result.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transactions_by_created_at
    by_created_at = transactions.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_created_at.created_at
    assert by_created_at.is_a?(Transaction)
  end

  def test_transaction_repository_returns_transactions_by_updated_at
    by_updated_at = transactions.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", by_updated_at.updated_at
    assert by_updated_at.is_a?(Transaction)
  end

#Find_by_all Method Tests
  def test_transaction_repository_finds_all_by_id
    all_by_id = transactions.find_all_by_id(4)
    assert_equal 1, all_by_id.count
    assert all_by_id.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_invoice_id
    all_by_invoice_id = transactions.find_all_by_invoice_id(5)
    assert_equal 1, all_by_invoice_id.count
    assert all_by_invoice_id.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_credit_card_number
    all_by_credit_card_number = transactions.find_all_by_credit_card_number("4354495077693036")
    assert_equal 1, all_by_credit_card_number.count
    assert all_by_credit_card_number.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_result_success
    all_by_result = transactions.find_all_by_result("success")
    assert_equal 83, all_by_result.count
    assert all_by_result.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_result_failed
    all_by_result = transactions.find_all_by_result("failed")
    assert_equal 16, all_by_result.count
    assert all_by_result.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_created_at
    all_by_created_at = transactions.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 20, all_by_created_at.count
    assert all_by_created_at.first.is_a?(Transaction)
  end

  def test_transaction_repository_finds_all_by_updated_at
    all_by_updated_at = transactions.find_all_by_updated_at ("2012-03-27 14:54:10 UTC")
    assert_equal 20, all_by_updated_at.count
    assert all_by_updated_at.first.is_a?(Transaction)
  end
end
