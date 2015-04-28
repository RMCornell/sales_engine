require 'csv'
require 'pry'

require_relative 'parser'

require_relative 'customer'
require_relative 'customer_repository'
# require_relative 'invoice'
# require_relative 'invoice_repository'
# require_relative 'merchant'
# require_relative 'merchant_repository'


class SalesEngine
  attr_reader :customer_repository, :dir

  def initialize(dir)
    @dir = dir
  end

  def startup
    customer_data = Parser.parse("#{dir}/customers.csv")
    # binding.pry
    @customer_repository = CustomerRepository.new#(customer_data, self)

    #@invoices  = InvoiceRepository.new(invoice_file, self)
  end


  # def invoice_repository
  #   # todo want this to be array of Invoice instances
  #   #@invoices = InvoiceRepository.new(invoices)
  # end
end

#
# if __FILE__ == $0
#   engine = SalesEngine.new('./data/customers.csv', './data/invoices.csv')
#   engine.startup
#
#   engine.customer_repository
#
#
#  binding.pry
#  puts 'asdf'
#   # engine.merchant_repository
#   # p engine.invoice_repository
#   # engine.item_repository
#   # engine.invoice_item_repository
#   # engine.transaction_repository
# end
