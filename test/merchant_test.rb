require_relative 'test_helper'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def sample_data
    {
        id: "1",
        name: "Schroeder-Jerde",
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def setup
    @merchant = Merchant.new(sample_data, repository = nil)
  end

  def test_merchant_exists
    assert merchant
  end

  def test_merchant_has_an_id
    assert_equal 1, merchant.id
  end

  def test_merchant_has_a_name
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_merchant_has_a_created_at_date
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_merchant_has_a_updated_at_date
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end
end
