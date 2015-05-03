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

  # //----------Merchant Relationships-------------------------------------------//
    # merchant(id) --> items(merchant_id) --> merchant#items
  def find_merchant_items_by_(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

    # merchant(id) --> invoices(merchant_id) --> # merchant#invoices
  def find_merchant_invoices_by_(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  # //---------- Invoice Relationships-------------------------------------------//
    # invoice(id) --> transaction(invoice_id) --> invoice#transactions
  def find_transactions_by_invoice_(id)
    transaction_repository.find_all_by_invoice_id(id)
  end



    # invoice(id) --> invoice_items(invoice_id) --> invoice#invoice_items

  def find_invoice_items_for_(invoice_id)  ### this should be returning the invoice_items not the items
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end #### fixed....









  # invoice(id) --> invoice_items(invoice_id) -->
  # invoice_items(item_id) --> items(id) -->


  def find_items_for_invoice_items(id) # invoice#items
    invoice = invoice_repository.find_by_id(id)
    items = invoice_item_repository.find_all_by_invoice_id(invoice.id)
    items.map { |item| item_repository.find_by_id(item.item_id) }
  end















  # invoice(customer_id) --> customer(id) --> invoice#customer
  def find_customer_by_(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  # invoice(merchant_id) --> merchant(id) --> invoice#merchant

  def find_merchant_by_(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end


  # //---------- InvoiceItem Relationships-------------------------------------------//

  # invoice_item(invoice_id) --> invoice(id) --> invoice_item#invoice


  def find_invoice_items_invoice_by_(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end





















  def find_invoice_items_items_by_(item_id) # invoice_item#item

   item = item_repository.find_by_id(item_id)
    #item_id.map { |item| item_repository.find_by_id(item.item_id) }



   # invoice = invoice_repository.find_by_id(1002)
   # invoice_items = invoice_item_repository.find_all_by_invoice_id(1002)
   # invoice_items.map { |item| item_repository.find_by_id(item.item_id) }


  end






















  # //---------- Item Relationships-------------------------------------------//


  def find_item_invoice_items_by_(id) # item#invoice_items
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_item_merchant_by_(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end




  # //---------- Transaction Relationships-------------------------------------------//

  # transactions(invoice_id) --> invoice(id) --> transaction#invoice


  # todo Failure/Error: expect(transaction.invoice.customer.first_name).to eq invoice_customer.first_name

  def find_invoice_by_(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end


  # //---------- Customer Relationships-------------------------------------------//
  # customer(id) --> invoice(customer_id)

  def find_invoices_by_(id) # customer#invoices
    invoice_repository.find_all_by_customer_id(id)
  end
end






# invoice = engine.invoice_repository.find_by_id 1002
# #items = engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
#
# item = invoice.items.find {|i| i.name == 'Item Accusamus Officia' }


# invoice_items = invoice_item_repository.find_all_by_invoice_id(id)
# item = invoice_item_repository.find_by_invoice_id(id)
# if invoice_items.size > 1
#   invoice_items.map do |item|
#     #next if item.nil?
#     #binding.pry
#     item_repository.find_by_id(item.item_id)
#   end
# else
#   item_id = invoice_items
#
#   ### from spec
#   #item = invoice.items.find {|i| i.name == 'Item Accusamus Officia' }
#   # item_list = item_repository.find_by_id(item_id)

