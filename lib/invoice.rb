class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice, repository)
    @invoice        = invoice
    @repository     = repository
    @id             = invoice[:id]
    @customer_id    = invoice[:customer_id]
    @merchant_id    = invoice[:merchant_id]
    @status         = invoice[:status]
    @created_at     = invoice[:created_at]
    @updated_at     = invoice[:updated_at]
  end

  def transactions
    #todo transactions returns a collection of associated Transaction instances
  end

  def invoice_items
    # todo invoice_items returns a collection of associated InvoiceItem instances
  end

  def items
    # todo items returns a collection of associated Items by way of InvoiceItem objects
  end

  def customer
    # todo customer returns an instance of Customer associated with this object
  end

  def merchant
    # todo merchant returns an instance of Merchant associated with this object
  end
end
