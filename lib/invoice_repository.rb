class InvoiceRepository
  include Enumerable

  attr_reader :invoices

  def initialize(engine, dir)
    @engine = engine
    load_invoices(dir)
    @invoices = []
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


  def all
    invoices
  end

  def find_by_id(id)
    invoices.detect { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    #todo find_by_status
  end

  def find_by_created_at(created_at)
    #todo find_by_created_at
  end

  def find_by_updated_at(updated_at)
    #todo find_by_updated_at
  end



  ### invoice relationships

  # invoice#transactions
  def find_transactions_by_(id)
    engine.find_transactions_by_(id)
  end



end




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
