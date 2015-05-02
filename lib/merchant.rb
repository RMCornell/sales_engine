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

  ### merchant(id) --> items(merchant_id)
  # merchant#items
  def items
    repository.find_items_by_(id)
  end

  def invoices
# todo invoices returns a collection of Invoice instances associated with that merchant from their known orders
  end
end
