require_relative './test_helper'

class TransactionTest < Minitest::Test

  def test_transaction_can_exist
    Transaction.new
  end
end
