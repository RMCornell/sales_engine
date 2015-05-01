class ItemRepository
  include Enumerable

  attr_reader :engine, :items

  def initialize(engine, dir)
    @engine = engine
    load_items(dir)
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
    items.detect { |item| id == item.id }
  end

  def find_by_name(name)

    items.detect {|item| name == item.name}
  end

  end
