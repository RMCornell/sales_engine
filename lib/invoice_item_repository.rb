class InvoiceItemRepository
  include Enumerable

  attr_reader :engine, :invoice_items

  def initialize(engine, dir)
    @engine = engine
    load_invoice_items(dir)
  end

  def load_invoice_items(dir)
    file = Parser.parse("#{dir}/invoice_items.csv")
    @invoice_items = file.map { |row| InvoiceItem.new(row, self) }
  end

  def inspect
    "#<#{self.class}: #{@invoice_items.size} rows>"
  end

  # --------- invoice item relationships ---------------------------------------------------------


  def find_invoice_items_invoice_by_(invoice_id) #invoice_item#invoice
    engine.find_invoice_items_invoice_by_(invoice_id)
  end

  def find_invoice_items_item_by_(item_id)
    engine.find_invoice_items_item_by_(item_id)
  end



  # ------------------------------------------------------------------------------------------------
  
  def each(&block)
    @invoice_items.each(&block)
  end

#-------------------- Base Repository Methods --------------------
  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

#-------------------- Find_by Methods --------------------
  def find_by_id(id)
    invoice_items.detect {|invoice_item| id == invoice_item.id}
  end


  def find_by_item_id(item_id)
    invoice_items.detect {|invoice_item| item_id == invoice_item.item_id }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.detect {|invoice_item| invoice_id == invoice_item.invoice_id}
  end

  def find_by_quantity(quantity)
    invoice_items.detect {|invoice_item| quantity == invoice_item.quantity}
  end

  def find_by_unit_price(unit_price)
    invoice_items.detect {|invoice_item| unit_price == invoice_item.unit_price}
  end

  def find_by_created_at(created_at)
    invoice_items.detect {|invoice_item| created_at == invoice_item.created_at}
  end

  def find_by_updated_at(updated_at)
    invoice_items.detect {|invoice_item| updated_at == invoice_item.updated_at}
  end

#-------------------- Find_all_by Methods --------------------
  def find_all_by_id(id)
    invoice_items.select {|invoice_item| id == invoice_item.id}
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select {|invoice_item| invoice_id == invoice_item.invoice_id}
  end

  def find_all_by_quantity(quantity)
    invoice_items.select {|invoice_item| quantity == invoice_item.quantity}
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.select {|invoice_item| unit_price == invoice_item.unit_price}
  end

  def find_all_by_created_at(created_at)
    invoice_items.select{|invoice_item| created_at == invoice_item.created_at}
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.select{|invoice_items| updated_at == invoice_items.updated_at}
  end
end
