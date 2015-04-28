require 'csv'

require_relative 'csv_parser'

require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
#require_relative 'merchant'
#require_relative 'merchant_repository'


class SalesEngine
  attr_reader :csv_s, :customers, :invoices

  def initialize(*csv_s)
    @csv_s = csv_s
    #todo find out how csv_s is coming in... array? separate strings?
  end

  def startup
    @customers = CsvParser.parse('../data/customers.csv')
    @invoices  = CsvParser.parse('../data/invoices.csv')
  end
end


if __FILE__ == $0
  engine = SalesEngine.new
  engine.startup

  # engine.merchant_repository
  # engine.invoice_repository
  # engine.item_repository
  # engine.invoice_item_repository
  # engine.customer_repository
  # engine.transaction_repository
end
