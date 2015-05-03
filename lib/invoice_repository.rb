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
    "#<#{self.class}: #{@items.size} rows>"  end

  def each(&block)
    @invoices.each(&block)
  end

  # invoice ------------------------------------------------------ relationships


  def find_transactions_by_invoice_(id) # invoice#transactions
    engine.find_transactions_by_invoice_(id)
  end

  def find_items_for_invoice_items(id)  # invoice#invoice_items
    engine.find_items_for_invoice_items(id)
  end



  def find_items_by_item_(id) # invoice#items
    engine.find_items_for_invoice_items(id)
  end




  def find_customer_by_(customer_id) # invoice#customer
    engine.find_customer_by_(customer_id)
  end

  def find_merchant_by_(merchant_id) # invoice#merchant
    engine.find_merchant_by_(merchant_id)
  end

#-------------------- Base Repository Methods --------------------

  def all
    invoices
  end

  def random
    invoices.sample
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
    invoices.detect { |invoice| invoice.status == status }
  end

  def find_by_created_at(created_at)
    invoices.detect { |invoice| invoice.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoices.detect { |invoice| invoice.updated_at == updated_at }
  end

#-------------------- Find_all_by Methods --------------------

  def find_all_by_id(id)
    invoices.select { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.select { |invoice| invoice.status == status }
  end

  def find_all_by_created_at(created_at)
    invoices.select { |invoice| invoice.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end
end



