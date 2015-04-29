class Customer

  attr_reader :repository, :id, :first_name, :last_name,
              :created_at, :updated_at

  def initialize(customer, repository)
     @repository = repository
     @id         = customer[:id].to_i
     @first_name = customer[:first_name]
     @last_name  = customer[:last_name]
     @created_at = customer[:created_at]
    @updated_at  = customer[:updated_at]
  end

  def invoices
    repository.find_invoices_by_customer_id(id)
  end
end
