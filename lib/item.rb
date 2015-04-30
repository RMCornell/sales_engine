class Item
  attr_reader :repository,
              :id,
              :name,
              :description,
              :unit_price,
              :merchang_id,
              :created_at,
              :updated_at

  def initialize(item, repository)
    @repository  = repository
    @id          = item[:id].to_i
    @name        = item[:name]
    @description = item[:description]
    @unit_price  = item[:unit_price]
    @merchant_id = item[:merchant_id]
    @created_at  = item[:created_at]
    @updated_at  = item[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect} name: #{@name.inspect} decription: #{@description.inspect} unit_price: #{@unit_price.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end

  def invoice_items
    #todo invoice_items returns a collection of InvoiceItems associated with this object
  end

  def merchant
    #todo merchant returns an instance of Merchant associated with this object
  end
end


