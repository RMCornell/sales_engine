class MerchantRepository
  attr_reader :merchant_data, :parent, :merchants

  def initialize(merchant_data, parent)
    @parent = parent
    @merchant_data = merchant_data
    @merchants = load_merchants(merchant_data)
  end

  def load_merchants(merchant_data)
    merchant_data.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_all
    #todo create all
  end

  def find_random
    #todo find random
  end

  def find_by_merchant_id
    #todo find by merchant id
  end

  def find_by_merchant_name
    #todo find_by_merchant_name
  end

  def find_by_created_at
    #todo find_by_created_at
  end

  def find_by_updated_at
    #todo find_by_updated_at
  end

  def find_all_by_merchant_id
    #todo find_all_by_merchant_id
  end

  def find_all_by_merchant_name
    #todo find_all_by_merchant_name
  end

  def find_all_by_created_at
    #todo find_all_by_updated_at
  end

  def find_all_by_updated_at
    #todo find_all_by_updated_at
  end
end