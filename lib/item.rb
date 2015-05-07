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


  # item(id) --> invoice_items(item_id) --> item#invoice_items
  def invoice_items
    repository.find_item_invoice_items_by_(id)
  end

  # item(merchant_id) --> merchant(id) --> # item#merchant
  def merchant
    repository.find_item_merchant_by_(merchant_id)
  end

  def quantity_sold
    invoice_items.inject(0) do |total, invoice_item|
      total + invoice_item.quantity
    end
  end

end


