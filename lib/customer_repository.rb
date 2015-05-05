require_relative 'customer'


class CustomerRepository
   include Enumerable

   attr_reader :engine, :customers

   def initialize(engine, dir)
     @engine = engine
     load_customers(dir)
   end

   def load_customers(dir)
     file = Parser.parse("#{dir}/customers.csv")
     @customers = file.map { |row| Customer.new(row, self) }
   end

   def each(&block)
     @customers.each(&block)
   end

   def inspect
     "#<#{self.class} #{@customers.size} rows>"
   end

  #-------------------- Relationship Methods --------------------
   # customer#invoices
   def find_invoices_by_(id)
     engine.find_invoices_by_(id)
   end


#-------------------- Base Repository Methods --------------------
  def all
    customers
  end

  def random
   customers.sample
  end

#-------------------- Find_by Methods --------------------
   def find_by_id(id)
     customers.detect { |customer| id == customer.id }
   end

   def find_by_first_name(first_name)
     customers.detect { |customer| first_name == customer.first_name }
   end

   def find_by_last_name(last_name)
     customers.detect {|customer| last_name == customer.last_name}
   end

   def find_by_created_at(created_at)
     customers.detect {|customer| created_at == customer.created_at}
   end

   def find_by_updated_at(updated_at)
     customers.detect {|customer| updated_at == customer.updated_at}
   end

#-------------------- Find_all_by Methods --------------------
   def find_all_by_id(id)
     customers.select {|customer| id == customer.id}
   end

   def find_all_by_first_name(first_name)
     customers.select {|customer| first_name == customer.first_name}
   end

   def find_all_by_last_name(last_name)
     customers.select {|customer| last_name == customer.last_name}
   end

   def find_all_by_created_at(created_at)
     customers.select {|customer| created_at == customer.created_at}
   end

   def find_all_by_updated_at(updated_at)
     customers.select {|customer| updated_at == customer.updated_at}
   end
 end

