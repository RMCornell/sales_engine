class ItemRepository
  include Enumerable

  attr_reader :engine, :items

  def initialize(engine)
    @engine = engine
  end

  def load_items(dir)
    file = Parser.parse("#{dir}/items.csv")
    @items = file.map { |row| Item.new(row, self) }
  end

  def inspect
    "#<#{self.class}: #{@items.size} rows>"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.detect { |item| item.id == id }
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
