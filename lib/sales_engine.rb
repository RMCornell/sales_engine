require 'csv'
require 'pry'

require_relative 'parser'

require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'item'
require_relative 'item_repository'



class SalesEngine
  attr_reader :customer_repository, :invoice_repository, :transaction_repository,
              :merchant_repository, :item_repository, :invoice_item_repository, :dir

  def initialize(dir)
    @dir = dir
  end

  def startup

    customer_data            = Parser.parse("#{dir}/customers.csv")
    @customer_repository     = CustomerRepository.new(customer_data, self)

    invoice_data             = Parser.parse("#{dir}/invoices.csv")
    @invoice_repository      = InvoiceRepository.new(invoice_data, self)

    transaction_data         = Parser.parse("#{dir}/transactions.csv")
    @transaction_repository  = TransactionRepository.new(transaction_data, self)

    merchant_data            = Parser.parse("#{dir}/merchants.csv")
    @merchant_repository     = MerchantRepository.new(merchant_data, self)

    item_data                = Parser.parse("#{dir}/items.csv")
    @item_repository         = ItemRepository.new(item_data, self)

    invoice_item_data        = Parser.parse("#{dir}/invoice_items.csv")
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)
  end
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
