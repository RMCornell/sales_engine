class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(invoice, repository)
    @repository  = repository
    @id          = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status      = invoice[:status]
    @created_at  = Date.parse(invoice[:created_at]) #Date.parse()
    @updated_at  = invoice[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect} cust_id: #{@customer_id.inspect} mer_id: #{@merchant_id.inspect}"\
    "status:#{@status.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end


    # invoice(id) --> transaction(invoice_id) --> invoice#transactions
  def transactions
    repository.find_transactions_by_invoice_(id)
  end

    # invoice(id) --> invoice_items(invoice_id) --> invoice#invoice_items
  def invoice_items
    repository.find_invoice_items_for_(id)
  end

  #invoice(id) --> invoice_items(invoice_id) --> invoice_items(item_id) --> items(id) --> invoice#items
  def items
    repository.find_items_by_item_(id) # invoice#items
  end

    # invoice(customer_id) --> customer(id) --> invoice#customer
  def customer
    repository.find_customer_by_(customer_id)
  end

    # invoice(merchant_id) --> merchant(id) --> invoice#merchant
  def merchant
    repository.find_merchant_by_(merchant_id)
  end
end
