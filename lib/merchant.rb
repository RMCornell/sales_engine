class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant, repository)
    @merchant = merchant
    @repository = repository
    @id = merchant[:id]
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchang[:updated_at]
  end

  def items
# todo items returns a collection of Item instances associated with that merchant for the products they sell
  end

  def invoices
# todo invoices returns a collection of Invoice instances associated with that merchant from their known orders
  end
end

