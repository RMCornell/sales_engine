class InvoiceRepository
  attr_reader :invoice_data, :parent, :invoices

  def initialize(invoice_data, parent)
    @parent = parent
    @invoice_data = invoice_data
    @invoice = load_invoices(invoice_data)
  end

  def load_invoices(invoice_data)
    invoice_data.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_all #todo find all
    @invoices
  end

  def random_invoice
    #todo find random invoice
  end

  def find_by_invoice_id(invoice_id)
    #todo find_by_invoice_id
  end

  def find_by_customer_id(customer_id)
    #todo find_by_customer_id
  end

  def find_by_merchant_id(merchant_id)
    #todo find_by_merchant_id
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
end
