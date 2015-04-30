class InvoiceItemRepository
  include Enumerable

  attr_reader :engine, :invoice_items

  def initialize(engine)
    @engine = engine
  end

  def load_invoice_items(dir)
    file = Parser.parse("#{dir}/invoice_items.csv")
    @invoice_items = file.map { |row| InvoiceItem.new(row, self) }
  end

  def inspect
    "#<#{self.class}: #{@invoice_items.size} rows>"
  end

  def each(&block)
    @invoice_items.each(&block)
  end


  def find_all
    #todo find_all
  end

  def find_random
    #todo find_random
  end

  def find_by_id
    #todo find_by_id
  end

  def find_by_item_id
    #todo find_by_item_id
  end

  def find_by_invoice_id
    #todo find_by_invoice_id
  end

  def find_by_quantity
    #todo find_by_quantity
  end

  def find_by_unit_price
    #todo find_by_unit_price
  end

  def find_all_by_id
    #todo find_all_by_id
  end

  def find_all_by_item_id
    #todo find_all_by_item_id
  end

  def find_all_by_invoice_id
    #todo find_all_by_invoice_id
    engine.invoice_repository.invoice_id
  end

  def find_all_by_quantity
    #todo find_all_by_quantity
  end

  def find_all_by_unit_price
    #todo find_all_by_unit_price
  end
end
