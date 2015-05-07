class Merchant
  attr_reader :repository,
              :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant, repository)
    @merchant   = merchant
    @repository = repository
    @id         = merchant[:id].to_i
    @name       = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect}>"
  end

  def items
    repository.find_merchant_items_by_(id)
  end

  def invoices
    repository.find_merchant_invoices_by_(id)
  end

  def revenue(date=nil)
    if date
      repository.find_merchant_revenue_by_date_(date, id)
    else
      repository.find_merchant_revenue_by_(id)
    end
  end

  def favorite_customer
    cust_id = repository.find_merchant_invoices_by_(id)
    best_customer = cust_id
        .each_with_object(Hash.new(0)) {|invoice,counts|
      counts[invoice.customer_id] += 1}
    top_cust_id = best_customer.max_by{|k, v| v}[0]
    repository.engine.find_customer_by_(top_cust_id)
  end

  def customers_with_pending_invoices
    repository.customers_with_pending_invoices(id)
  end
end
