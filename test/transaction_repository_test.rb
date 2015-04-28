require_relative './test_helper'

class TransactionRepositoryTest < Minitest::Test

  def test_transaction_repo_can_exist
    assert TransactionRepository.new
  end
end
