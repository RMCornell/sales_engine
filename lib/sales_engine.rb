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
  include Enumerable
  attr_reader :customer_repository,
              :invoice_repository,
              :transaction_repository,
              :merchant_repository,
              :item_repository,
              :invoice_item_repository,
              :dir

  def initialize(dir)
    @dir = dir
    startup
  end

  def startup
    #puts Time.now
    initialize_customer_repository
    initialize_invoice_repository
    initialize_transaction_repository
    initialize_merchant_repository
    initialize_item_repository
    initialize_invoice_item_repository
    #puts Time.now
  end

  def initialize_customer_repository
    @customer_repository ||= CustomerRepository.new(self, dir)
  end

  def initialize_invoice_repository
    @invoice_repository ||= InvoiceRepository.new(self, dir)
  end

  def initialize_transaction_repository
    @transaction_repository ||= TransactionRepository.new(self, dir)
  end

  def initialize_merchant_repository
    @merchant_repository ||= MerchantRepository.new(self, dir)
  end

  def initialize_item_repository
    @item_repository ||= ItemRepository.new(self, dir)
  end

  def initialize_invoice_item_repository
    @invoice_item_repository ||= InvoiceItemRepository.new(self, dir)
  end

  # //---------- Relationships-------------------------------------------//

  ### customer(id) --> invoice(customer_id)
  # customer#invoices
  def find_invoices_by_(id)
    invoice_repository.find_by_customer_id(id)
  end

  ### transactions(invoice_id) --> invoice(id)
  # transaction#invoice
  def find_invoice_by_(invoice_id)
    invoice_repository.find_by_invoice_id(invoice_id)
  end


  ### merchant(id) --> items(merchant_id)
  # merchant#items

  def find_items_by_merchant_(id)
    item_repository.find_by_merchant_id(id)
  end

  ### merchant(id) --> invoices(merchant_id)
  # merchant#invoices

  ### invoice(customer_id) --> customer(id)

  def find_customer_by_customer_(id)
    customer_repository.find_by_id(id)
  end




  def find_invoices_by_merchant_(id)
    invoice_repository.find_by_merchant_id(id)
  end


  def find_transactions_by_invoice_id(id)
    transaction_repository.find_by_invoice_id(id)
  end


end
