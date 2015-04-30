class ItemRepository
  attr_reader :engine, :items

  def initialize(engine, dir)
    @engine = engine
    @items = load_items(dir)
  end

  def load_items(dir)
    Parser.parse("#{dir}/items.csv").map do |row|
      Item.new(row, self)
    end
  end


















  def find_all
    #todo find all
  end

  def find_random
    #todo find_random
  end

  def find_by_id
    #todo find_by_id
  end

  def find_by_name
    #todo find_by_name
  end

  def find_by_desciption
    #todo find_by_description
  end

  def find_by_unit_price
    #todo find_by_unit_price
  end

  def find_by_merchant_id
    #todo find_by_merchant_id
  end

  def find_by_created_at
    #todo find_by_created_at
  end

  def find_all_by_id
    #todo find_by_id
  end

  def find_all_by_name
    #todo find_all_by_name
  end

  def find_all_by_description
    #todo find_all_by description
  end

  def find_all_by_unit_price
    #todo find_all_by_unit_price
  end

  def find_all_by_merchant_id
    #todo find_all_by_merchant_id
  end

  def find_all_by_created_at
    #todo find_all_by_created_at
  end
end
