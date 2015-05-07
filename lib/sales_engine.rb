require 'csv'
require 'pry'
require 'bigdecimal'
require_relative 'parser'

require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'


### todo move child classes to repos


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
    initialize_customer_repository
    initialize_invoice_repository
    initialize_transaction_repository
    initialize_merchant_repository
    initialize_item_repository
    initialize_invoice_item_repository
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
  def find_invoice_items_for_(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

    # invoice(id) --> invoice_items(invoice_id) --> invoice_items(item_id) --> items(id) --> # invoice#items
  def find_items_for_invoice_items(invoice_id)
    items = invoice_item_repository.find_all_by_invoice_id(invoice_id)
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

    # invoice_item(item_id) --> item(id) --> # invoice_item#item
  def find_invoice_items_items_by_(item_id)
    item_repository.find_by_id(item_id)
  end


  # //---------- Item Relationships-------------------------------------------//


    # item(id) --> invoice)item(item_id) --> item#invoice_item
  def find_item_invoice_items_by_(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

    # item(merchant_id) --> merchant(id) --> item#merchant
  def find_item_merchant_by_(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end


  # //---------- Transaction Relationships-------------------------------------------//


    # transactions(invoice_id) --> invoice(id) --> transaction#invoice
  def find_invoice_by_(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end


  # //---------- Customer Relationships-------------------------------------------//


    # customer(id) --> invoice(customer_id) --> # customer#invoices
  def find_invoices_by_(id)
    invoice_repository.find_all_by_customer_id(id)
  end


  # //---------- Business Logic -------------------------------------------//


  def find_merchant_revenue_by_(id) # merchant#revenue
    transaction_repository.successful_transactions
      .map { |transaction| transaction.invoice }
      .select { |invoice| invoice.merchant_id == id }
      .map { |invoice| invoice.invoice_items }
      .map { |item| item.map { |sub| sub.total } } # todo method to total all invoices
      .flatten.reduce(:+).to_d / 100
  end

  def find_merchant_revenue_by_date_(date=nil, id) #merchant#revenue(date=nil)
     revenue_by_date = transaction_repository.successful_transactions # todo add date filter
       .map { |transaction| transaction.invoice }
       .select { |invoice| invoice.merchant_id == id } # todo method to select merchant invoices
       .select { |invoice| invoice.created_at == date }
     total_revenue_for_all_invoices(revenue_by_date)
  end

  def total_revenue_for_all_invoices(invoices)
    invoice_items_for_each_invoice = invoices.map { |invoice| invoice.invoice_items }
    calculate_invoice_totals(invoice_items_for_each_invoice)
  end

  def calculate_invoice_totals(invoice_items) ### this calculates invoice totals
    invoice_items.flatten.reduce(0) { |total, invoice_item| total + invoice_item.total }.to_d / 100
  end

  def customers_with_pending_invoices(merchant_id)
    merchant_invoices = invoice_repository.find_all_by_merchant_id(merchant_id)
    merchant_invoices = merchant_invoices.reject { |invoice| invoice_repository.paid_invoices.include?(invoice) }
    merchant_invoices.map { |invoice| invoice.customer }
  end

  def create_new_invoice_item(invoice_items, row)
    invoice_item_repository.add_invoice_items(invoice_items, row)
  end

  def add_transaction(invoice)
    transaction_repository.add_transaction(invoice)
  end
end
