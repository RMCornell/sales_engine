 class CustomerRepository
   include Enumerable


   attr_reader :customer_data, :engine, :customers

   def initialize(customer_data, engine)
      @customer_data = customer_data
      @engine        = engine
      @customers     = load_customers(customer_data)
   end

   def load_customers(customer_data)
     customer_data.map do |row|
       Customer.new(row, self)
     end
   end

   def each(&block)
     @customers.each(&block)
   end


   def find_invoices_by_customer_id(id)
     engine.find_invoices_by_customer_id(id)
   end

   def all
     @customers
   end

   def random
     @customers.sample
   end

   def find_customer_by_id(id)
     @customers.select { |customer| customer.id == id}
   end

   # todo need .downcase and possibly regex
   def find_customer_by_first_name(first_name)
     @customers.select {|customer| first_name == customer.first_name}
   end

   def find_customer_by_last_name(last_name)
     @customers.select {|customer| last_name == customer.last_name}
   end

   def find_customer_by_created_at(time)
     # todo
   end

   def find_customer_by_updated_at(time)
     # todo
   end

   def find_all_customers_by_id(id)
     # todo
   end

   def find_all_customers_by_last_name(last_name)
     # todo
   end

   def find_all_customers_by_first_name(first_name)
     # todo
   end

   def find_all_customers_by_created_at(time)
     # todo
   end

   def find_all_customers_by_modified_at(time)
     # todo
   end
 end

