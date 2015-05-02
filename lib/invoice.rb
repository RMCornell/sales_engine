class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(invoice, repository)
    @repository     = repository
    @id             = invoice[:id].to_i
    @customer_id    = invoice[:customer_id].to_i
    @merchant_id    = invoice[:merchant_id].to_i
    @status         = invoice[:status]
    @created_at     = invoice[:created_at]
    @updated_at     = invoice[:updated_at]
  end

  def inspect
    "#<Invoice: id:#{@id.inspect} customer_id: #{@customer_id.inspect} merchant_id: #{@merchant_id.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end



  #  invoice#transactions
  def transactions
    repository.find_transactions_by_invoice_(id)
  end

  #  invoice#invoice_items
  def invoice_items
    repository.find_invoice_items_by_invoice_(id)
  end

  #invoice(id) --> invoice_items(invoice_id) --> invoice_items(item_id) --> items(id) --> invoice#items

  def items
    invoice_items = repository.find_invoice_items_by_invoice_(id)
   # binding.pry
   # repository.find_items_by_item_(id)

    repository.find_items_by_item_(invoice_items.item_id)
  end

  # invoice#customer
  def customer
    repository.find_customer_by_customer_(id)
  end

  def merchant
    # todo merchant returns an instance of Merchant associated with this object
  end
end
# transactions returns a collection of associated Transaction instances
# invoice_items returns a collection of associated InvoiceItem instances
# items returns a collection of associated Items by way of InvoiceItem objects
# customer returns an instance of Customer associated with this object
# merchant returns an instance of Merchant associated with this object
