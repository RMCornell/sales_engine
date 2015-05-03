require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :repository,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item, repository)
    @repository  = repository
    @id          = item[:id].to_i
    @name        = item[:name]
    @description = item[:description]
    @unit_price  = BigDecimal.new(item[:unit_price])/100
    @merchant_id = item[:merchant_id].to_i
    @created_at  = item[:created_at]
    @updated_at  = item[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect} name: #{@name.inspect} unit_price: #{@unit_price.inspect} merchant_id: #{@merchant_id.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end

  def invoice_items
    #todo invoice_items returns a collection of InvoiceItems associated with this object
  end

  def merchant
    #todo merchant returns an instance of Merchant associated with this object
  end
end


