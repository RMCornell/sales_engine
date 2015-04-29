class Customer

  attr_accessor :repository, :id, :first_name

  def initialize(customer, repository)
    @id         = customer[:id].to_i
    @first_name = customer[:first_name]
    @repository = repository

  end



  def invoices
    repository.find_invoices_by_customer_id(@id)
  end
end
