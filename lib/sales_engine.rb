require 'csv'
require 'pry'

require_relative 'parser'

require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
#require_relative 'merchant'
#require_relative 'merchant_repository'


class SalesEngine
  attr_reader :csv_s, :customers, :invoices, :customer_file, :invoice_file

  #todo find out how csv_s is coming in... array? separate strings?
  #def initialize(*csv_s)
    #@csv_s = csv_s
  def initialize(customer_file, invoice_file)
    @customer_file = Parser.parse(customer_file)
    @invoice_file  = Parser.parse(invoice_file)
  end

  def startup
    @customers = CustomerRepository.new(customer_file, self)
    #@invoices  = InvoiceRepository.new(invoice_file, self)
  end

  def customer_repository
    @customers


    # todo want this to be array of Customer instances
    #@customers = CustomerRepository.new(customers)
  end

  def invoice_repository
    # todo want this to be array of Invoice instances
    #@invoices = InvoiceRepository.new(invoices)
  end
end


if __FILE__ == $0
  engine = SalesEngine.new('./data/customers.csv', './data/invoices.csv')
  engine.startup

  # engine.merchant_repository
  p engine.invoice_repository
  # engine.item_repository
  # engine.invoice_item_repository
  p engine.customer_repository
  # engine.transaction_repository
end
