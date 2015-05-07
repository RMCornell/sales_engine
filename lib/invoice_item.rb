class InvoiceItem
  attr_reader :repository,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item, repository)
    @repository = repository
    @id         = invoice_item[:id].to_i
    @item_id    = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity   = invoice_item[:quantity].to_i
    @unit_price = invoice_item[:unit_price].to_i
    @created_at = invoice_item[:created_at]
    @updated_at = invoice_item[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect}>"
  end

  def invoice
    repository.find_invoice_items_invoice_by_(invoice_id)
  end

  def item
    repository.find_invoice_items_items_by_(item_id)
  end

  def total
    quantity * unit_price
  end
end
