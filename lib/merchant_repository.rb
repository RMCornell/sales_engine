class MerchantRepository
  attr_reader :engine, :merchants

  def initialize(engine)
    @engine = engine
  end

  def load_merchants(dir)
    file = Parser.parse("#{dir}/merchants.csv")
    @merchants = file.map { |row| Merchant.new(row, self) }
  end

  def inspect
    "#<#{self.class}: #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
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
