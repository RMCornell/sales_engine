require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @engine = SalesEngine.new('./data')
    @engine.initialize_customer_repository
    # @customers...
  end

end
