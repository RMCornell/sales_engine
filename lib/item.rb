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
  def invoice_items #item#invoice_items

    repository.find_item_invoice_items_by_(id)
    #todo invoice_items returns a collection of InvoiceItems associated with this object
  end

  # item(merchant_id) --> merchant(id) --> # item#merchant
  def merchant # item#merchant
    repository.find_item_merchant_by_(merchant_id)
  end

  def revenue
    selected_invoices ||= invoice_items.map { |invoice_item|
      invoice_item.invoice }

    selected_invoices.uniq!

    selected_transactions ||= selected_invoices.map { |invoice|
      invoice.transactions }.flatten

    successful_transactions ||= selected_transactions.select { |transaction|
      transaction.result == "success" }

    successful_invoices ||= successful_transactions.map { |transaction|
      transaction.invoice }

    successful_invoice_items ||= successful_invoices.map { |invoice|
      invoice.invoice_items }.flatten

    invoice_items_for_item ||= successful_invoice_items.select { |invoice_item|
      invoice_item.item_id == id }

    item_revenue = invoice_items_for_item.map { |invoice_item|
      invoice_item.unit_price * invoice_item.quantity }

    item_revenue.flatten.reduce(0, :+)
  end


  def quantity_sold
    selected_invoices ||= invoice_items.map { |invoice_item|
      invoice_item.nil? ? [] : invoice_item.invoice }

    selected_invoices.uniq!

    selected_transactions ||= selected_invoices.map { |invoice|
      invoice.transactions }.flatten

    successful_transactions ||= selected_transactions.select { |transaction|
      transaction.result == "success" }

    successful_invoices ||= successful_transactions.map { |transaction|
      transaction.invoice }.uniq

    successful_invoice_items ||= successful_invoices.map { |invoice|
      invoice.invoice_items }.flatten

    invoice_items_for_item ||= successful_invoice_items.select { |invoice_item|
      invoice_item.item_id == id }

    invoice_items_for_item.flatten.map { |invoice_item|
      invoice_item.quantity }.reduce(:+)
  end

  def items_invoices
    @items_invoices ||= invoice_items.map do |invoice_item|
      invoice_item.nil? ? [] : invoice_item.invoice
    end.uniq
  end

  def invoices_transactions(items_invoices)
    @invoices_transactions ||= items_invoices.flat_map do |invoice|
      invoice.transactions
    end
  end

  def successful_transactions(invoices_transactions)
    @successful_transactions ||= invoices_transactions.reject do |transaction|
      !transaction.successful?
    end
  end

  def successful_invoices(successful_transactions)
    @successful_invoices ||= successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_invoice_items(successful_invoices)
    @successful_invoice_items ||= successful_invoices.flat_map do |invoice|
      invoice.invoice_items
    end
  end

  def final_invoice_items(successful_invoice_items)
    @final_invoice_items ||= successful_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def most_sold
    invoice_items.max_by { |invoice_item| invoice_item.quantity }
  end
end