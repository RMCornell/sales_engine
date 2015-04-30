class InvoiceRepository
  include Enumerable
  attr_reader :engine, :invoices

  def initialize(engine, dir)
    @engine = engine
    @invoices = load_invoices(dir)
  end

  def each(&block)
    @invoices.each(&block)
  end

  def load_invoices(dir)
    Parser.parse("#{dir}/invoices.csv").map do |row|
      Invoice.new(row, self)
    end
  end



















  def find_by_invoice_id(invoice_id)
    invoices.find { |invoice| invoice.id == invoice_id }
  end

  def find_customer_by_customer_id(customer_id)
    engine.find_customer_by_customer_id(customer_id)
  end

  def find_transactions_by_invoice_id(id)
    engine.find_transactions_by_invoice_id(id)
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
# def find_by_merchant_id(merchant_id)
#   #todo find_by_merchant_id
# end
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
