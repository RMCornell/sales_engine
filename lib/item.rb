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
    @repository = repository
    @item = item[:id].to_i
    @first_name = item[:first_name]
    @last_name = item[:last_name]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
  end

  def invoice_items
    #todo invoice_items returns a collection of InvoiceItems associated with this object
  end

  def merchant
    #todo merchant returns an instance of Merchant associated with this object
  end
end


