require 'pry'
class Customer

  attr_reader :id,
              :repository,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer, repository)
      @repository = repository
      @id         = customer[:id].to_i
      @first_name = customer[:first_name]
      @last_name  = customer[:last_name]
      @created_at = customer[:created_at]
     @updated_at  = customer[:updated_at]
  end

  def inspect
    "#<Customer:> id: #{@id.inspect} first_name: #{@first_name.inspect} last_name:"\
    "#{@last_name.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}"
  end


  ### customer(id) --> invoice(customer_id) --> customer#invoices
  def invoices
    repository.find_invoices_by_(id)
  end

  def transactions
    repository.customer_transactions(id)
  end

  def favorite_merchant
    x = invoices
    f_mer = 0
    x.select do |i|
      if i.status == "shipped"
        f_mer = i.merchant_id
      end
    end
    repository.engine.merchant_repository.find_by_id(f_mer)
  end
end
