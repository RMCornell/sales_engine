class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

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
    "#<Invoice: id:#{@id.inspect} customer_id: #{@customer_id.inspect} merchant_id: #{@merchant_id.inspect} status:#{@status.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end


  # def customer
  #   @repository.find_customer_by_customer_id(customer_id)
  # end
  #
  # def transactions
  #   @repository.find_transactions_by_invoice_id(id)
  # end
  #todo transactions returns a collection of associated Transaction instances


















  def invoice_items
    # todo invoice_items returns a collection of associated InvoiceItem instances
  end

  def items
    # todo items returns a collection of associated Items by way of InvoiceItem objects
  end

  def merchant
    # todo merchant returns an instance of Merchant associated with this object
  end
end
