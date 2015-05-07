require_relative 'item'

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

  # --------------------- Relationship Methods --------------------------

  def find_item_invoice_items_by_(id) # item#invoice_items
    engine.find_item_invoice_items_by_(id)
  end

  def find_item_merchant_by_(merchant_id) # item#merchant
    engine.find_merchant_by_(merchant_id)
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

#Find_by Methods
  def find_by_name(name)
    items.detect {|item| name == item.name}
  end

  def find_by_description(description)
    items.detect{|item| description == item.description}
  end

  def find_by_unit_price(unit_price)
    items.detect{|item| unit_price == item.unit_price}
  end

  def find_by_merchant_id(id)
    items.detect { |item| item.merchant_id == id }
  end

  def find_by_created_at(created_at)
    items.detect {|item| created_at == item.created_at}
  end

  def find_by_updated_at(updated_at)
    items.detect {|item| updated_at == item.created_at}
  end

#Find_all_by methods
  def find_all_by_id(id)
    items.select{|item| id == item.id}
  end

  def find_all_by_name(name)
    items.select{|item| name == item.name}
  end

  def find_all_by_description(description)
    items.select{|item| description == item.description}
  end

  def find_all_by_unit_price(unit_price)
    items.select{|item|  unit_price == item.unit_price}
  end

  def find_all_by_merchant_id(merchant_id)
    items.select{|item| merchant_id == item.merchant_id}
  end

  def find_all_by_created_at(created_at)
    items.select{|item| created_at == item.created_at}
  end

  def find_all_by_updated_at(updated_at)
    items.select {|item| updated_at = item.updated_at}
  end

  #Business intellingence
  def most_revenue(x)
    items.sort_by do |item|
      item.revenue.nil? ? 0 : item.revenue
    end.reverse.first(x)
  end

  def most_items(x)
    items.sort_by do |item|
      item.quantity_sold.nil? ? 0 : item.quantity_sold
    end.reverse.first(x)
  end

end

=begin

def favorite_customer
    cust_id = repository.find_merchant_invoices_by_(id)
    best_customer = cust_id.each_with_object(Hash.new(0)) {|invoice,counts| counts[invoice.customer_id] += 1}
    top_cust_id = best_customer.max_by{|k, v| v}[0]
    repository.engine.find_customer_by_(top_cust_id)
  end

=end