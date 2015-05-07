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
    @created_at  = Date.parse(invoice[:created_at])
    @updated_at  = invoice[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect}>"
  end

  def transactions
    repository.find_transactions_by_invoice_(id)
  end

  def invoice_items
    repository.find_invoice_items_for_(id)
  end

  def items
    repository.find_items_by_item_(id)
  end

  def customer
    repository.find_customer_by_(customer_id)
  end

  def merchant
    repository.find_merchant_by_(merchant_id)
  end

  def charge(invoice)
    transaction_data = {
        invoice_id: id,
        cc_number: invoice[:credit_card_number],
        cc_expiration_date: invoice[:credit_card_expiration],
        result: invoice[:result]
    }
    repository.add_transaction(transaction_data)
  end
end
