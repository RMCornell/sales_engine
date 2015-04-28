 class CustomerRepository
   attr_accessor :customer_data, :parent, :customers,

  def initialize(customer_data, parent)
    @parent = parent
    @customer_data   = customer_data
    @customers = load_customers(customer_data)
  end
#
  def load_customers(customer_data)
    @customer_data.map do |row|
      Customer.new(row, self)
    end
  end
#
  def all
    @customers
  end
#
  def find_invoices_by_customer_id(id)
    @engine.find_invoices_by_customer_id(@id)
  end
#
  def find_customer_by_id(id)
    @customers[id]
  end
#
end
