class CustomerRepository
  attr_accessor :customers, :parent

  def initialize(customers, parent)
    @parent = parent # name parent?
    @customers   = customers

    @customers.map do |customer|
      cust = Customer.new

      cust.id         = customer[:id]
      cust.first_name = customer[:first_name]
      cust.parent     = self
      puts "parent: #{cust.parent} id: #{cust.id} first_name: #{cust.first_name}"
    end
    @customers

    def find_invoices_by_customer_id(id)
      @engine.find_invoices_by_customer_id(@id)
    end
  end
end
