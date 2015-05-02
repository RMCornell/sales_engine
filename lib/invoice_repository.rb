class InvoiceRepository
  include Enumerable


  attr_reader :engine, :invoices

  def initialize(engine, dir)
    @engine = engine
    load_invoices(dir)
  end

  def load_invoices(dir)
    file = Parser.parse("#{dir}/invoices.csv")
    @invoices = file.map { |row| Invoice.new(row, self) }
  end

  def inspect
    "#<InvoiceRepository: id: #{@id.inspect} customer_id: #{@customer_id.inspect} merchant_id:#{@merchant_id.inspect} status: #{@status.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect} >"
  end

  # invoice ------------------------------------------------------ relationships

  # invoice#transactions
  def find_transactions_by_invoice_(id)
    engine.find_transactions_by_invoice_(id)
  end

  # invoice#invoice_items
  def find_invoice_items_by_invoice_(id)
    engine.find_invoice_items_by_invoice_(id)
  end


  # invoice#items

  def find_items_by_item_(id)
    engine.find_items_by_item_(id)
  end


  # invoice#customer
  def find_customer_by_customer_(id)
    engine.find_customer_by_customer_(id)
  end



  # invoice#merchant
  def find_merchant_by_(merchant_id)
    engine.find_merchant_by_(merchant_id)
  end




  ##### find_by methods
  def each(&block)
    @invoices.each(&block)
  end

#-------------------- Base Repository Methods --------------------
  def all
    invoices
  end

  def random
    invoices.sample(1)
  end

#-------------------- Relationship Methods --------------------
  def find_transactions_by_invoice_id(id)
    engine.find_transactions_by_invoice_id(id)
  end


#-------------------- Find_by Methods --------------------
  def find_by_id(id)
    invoices.detect { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.detect { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.detect { |invoice| invoice.merchant_id == merchant_id }
  end


  def find_by_status(status)
    invoices.detect {|invoice| status == invoice.status}
  end

  def find_by_created_at(created_at)
    invoices.detect {|invoice| created_at == invoice.created_at}
  end

  def find_by_updated_at(updated_at)
    invoices.detect{|invoice| updated_at == invoice.updated_at}
  end

#-------------------- Find_all_by Methods --------------------
  def find_all_by_id(id)
    invoices.select{|invoice| id == invoice.id}
  end

  def find_all_by_customer_id(customer_id)
    invoices.select{|invoice| customer_id == invoice.customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select{|invoice| merchant_id == invoice.merchant_id}
  end

  def find_all_by_status(status)
    invoices.select{|invoice| status == invoice.status}
  end

  def find_all_by_created_at(created_at)
    invoices.select{|invoice|created_at == invoice.created_at}
  end

  def find_all_by_updated_at(updated_at)
    invoices.select{|invoice| updated_at == invoice.updated_at}
  end
end



