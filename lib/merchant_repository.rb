class MerchantRepository
  attr_reader :engine, :merchants

  def initialize(engine, dir)
    @engine = engine
    @merchants = load_merchants(dir)
  end

  def load_merchants(dir)
    Parser.parse("#{dir}/merchants.csv").map do |row|
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
