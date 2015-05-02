class InvoiceRepository
  include Enumerable

  attr_reader :invoices, :engine


  def initialize(engine, dir)
    @engine = engine
    load_invoices(dir)
  end

  def each(&block)
    @invoices.each(&block)
  end

  def load_invoices(dir)
    file = Parser.parse("#{dir}/invoices.csv")
    @invoices = file.map { |row| Invoice.new(row, self) }
  end

  def inspect
    "#<InvoiceRepository: id: #{@id.inspect} customer_id: #{@customer_id.inspect} merchant_id:#{@merchant_id.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect} >"
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




  ##### find_by methods
  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.detect { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    @invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(id)
    @invoices.select { |invoice| invoice.merchant_id == id }
  end

  #
  # def find_by_invoice_id(invoice_id)
  #   @invoices.find { |invoice| invoice.id == invoice_id }
  # end

  ## find all methods


  # def find_all #todo find all
  #   @invoices
  # end
  #
  # def random_invoice
  #   #todo find random invoice
  # end
  #
  #
  #

  #
  # def find_by_status(status)
  #   #todo find_by_status
  # end
  #
  # def find_by_created_at(created_at)
  #   #todo find_by_created_at
  # end
  #
  # def find_by_updated_at(updated_at)
  #   #todo find_by_updated_at
  # end



end



