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
  attr_reader :customer_repository,
              :invoice_repository,
              :transaction_repository,
              :merchant_repository,
              :item_repository,
              :invoice_item_repository,
              :dir

  def initialize(dir)
    @dir = dir
  end

  def startup
    @customer_repository     ||= CustomerRepository.new(self, dir)
    @invoice_repository      ||= InvoiceRepository.new(self, dir)
    @transaction_repository  ||= TransactionRepository.new(self, dir)
    @merchant_repository     ||= MerchantRepository.new(self, dir)
    @item_repository         ||= ItemRepository.new(self, dir)
    @invoice_item_repository ||= InvoiceItemRepository.new(self, dir)
  end


  def find_invoices_by_customer_id(customer_id)
    invoice_repository.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_customer_by_customer_id(customer_id)
    customer_repository.find_by_customer_id(customer_id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_by_invoice_id(id)
  end



end











# def find_by_invoice_id(invoice_id)
#   invoice_repository.select { |invoice| invoice.id == invoice_id}
# end
#
#
#
#
# def find_items_by_merchant_id
#   item_repository.select { |item| item == merchant_id }
# end
