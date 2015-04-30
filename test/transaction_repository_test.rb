require_relative 'test_helper'


class TransactionRepositoryTest < Minitest::Test


  def setup
    @engine = SalesEngine.new('./data')
    @transactions = @engine.transaction_repository
  end

  def test_transactions_can_exist
    assert @transactions
  end

  def test_transactions_have_a_repository
    assert @transactions
  end

  def test_transactions_have_an_id
    refute @transactions.transactions.any? { |transaction| transaction.id.nil? }
  end

  def test_transactions_have_an_invoice_id
    refute @transactions.transactions.any? { |transaction| transaction.invoice_id.nil? }
  end

  def test_transactions_have_a_credit_card_number
    refute @transactions.transactions.any? { |transaction| transaction.credit_card_number.nil? }
  end

  def test_transaction_has_credit_card_expiration_date
    assert @transactions.transactions.any? { |transaction| transaction.credit_card_expiration_date.nil? }
  end

  def test_transaction_has_a_result
    refute @transactions.transactions.any? { |transaction| transaction.result.nil? }
  end

  def test_transactions_have_a_created_at_date
    refute @transactions.transactions.any? { |transaction| transaction.created_at.nil? }
  end

  def test_transactions_have_an_updated_at_date
    refute @transactions.transactions.any? { |transaction| transaction.updated_at.nil? }
  end

end

