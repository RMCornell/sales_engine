class Customer
  attr_accessor :id, :parent, :first_name

  def invoices
    @customers.find_invoices_by_customer_id(@id)
  end
end
