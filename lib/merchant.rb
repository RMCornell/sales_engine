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
    "#<#{self.class}: id:#{@id.inspect} name: #{@name.inspect}  created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end

  #-------------------- Relationship Methods --------------------


    # merchant(id) --> items(merchant_id) -->  merchant#items
  def items
    repository.find_merchant_items_by_(id)
  end

    # merchant(id) --> invoices(merchant_id) --> merchant#invoices
  def invoices
    repository.find_merchant_invoices_by_(id)
  end


  #-------------------- Business Logic --------------------

    # revenue returns the total revenue for that merchant across all transactions
    # merchant --> invoices --> transactions
    # successful transactions --> invoices --> merchant invoices --> invoice items
  # def revenue
  #   repository.find_merchant_revenue_by_(id)
  # end

    # returns the total revenue for that merchant for a specific invoice date

  def revenue(date=nil) # todo can refactor into one with revenue?
    repository.find_merchant_revenue_by_date_(id, date)
  end


























  def favorite_customer
    repository.find_by_id(id)
    binding.pry

    #goto merchant repo (using id)
    #goto sales_engine (using_id)
    #goto invoice_repository (using_id)
    #find all invoices matching merchant_id
    #sort by customer_id
    #take highest customer_id
    #return to sales_engine(with customer_id)
    #go to customer repository (using customer_id)
    #find customer_id and return first and last names
  end
end
