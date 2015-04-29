class InvoiceItemRepository
  attr_reader :invoice_item_data, :parent, :invoice_item

  def initialize(invoice_item_data, parent)
    @parent = parent
    @invoice_item_data = invoice_item_data
    @invoice_item = load_items(invoice_item_data)
  end

  def load_items(invoice_items_data)
    invoice_items_data.map do |row|
      InvoiceItem.new(row, self)
    end
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
