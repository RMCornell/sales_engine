class Merchant
  attr_reader :repository,
              :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant, repository)
    @merchant = merchant
    @repository = repository
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect} name: #{@name.inspect}  created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end

  def items
# todo items returns a collection of Item instances associated with that merchant for the products they sell
  end

  def invoices
# todo invoices returns a collection of Invoice instances associated with that merchant from their known orders
  end
end



