require_relative 'merchant'

class MerchantRepository
  include Enumerable

  attr_reader :engine, :merchants

  def initialize(engine, dir)
    @engine = engine
    load_merchants(dir)
  end

  def load_merchants(dir)
    file = Parser.parse("#{dir}/merchants.csv")
    @merchants = file.map {|row| Merchant.new(row, self) }
  end

  def each(&block)
    @merchants.each(&block)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  # merchant#items
  def find_merchant_items_by_(id)
    engine.find_merchant_items_by_(id)
  end

  # merchant#invoices
  def find_merchant_invoices_by_(id)
    engine.find_merchant_invoices_by_(id)
  end

#Merchant Repository Methods

  def all
    merchants
  end

  def random
    merchants.sample
  end

#Find_by Methods
  def find_by_id(id)
    merchants.detect { |merchant| id == merchant.id }
  end

  def find_by_name(merchant_name)
    merchants.detect { |merchant| merchant_name == merchant.name}
  end

  def find_by_created_at(created_at)
    merchants.detect { |merchant| created_at == merchant.created_at}
  end

  def find_by_updated_at(updated_at)
    merchants.detect { |merchant| updated_at == merchant.updated_at}
  end

#Find_by_all Methods
  def find_all_by_id(id)
    merchants.select { |merchant| id == merchant.id }
  end

  def find_all_by_name(merchant_name)
    merchants.select { |merchant| merchant_name == merchant.name}
  end

  def find_all_by_created_at(created_at)
    merchants.select { |merchant| created_at == merchant.created_at}
  end

  def find_all_by_updated_at(updated_at)
    merchants.select { |merchant| updated_at == merchant.updated_at}
  end

  # -------- Business Logic ------------------------

  def find_merchant_revenue_by_(id) # merchant#revenue
    engine.find_merchant_revenue_by_(id)
  end

  def find_merchant_revenue_by_date_(date=nil, id) # merchant#revenue(date)
    engine.find_merchant_revenue_by_date_(date, id)
  end

  def revenue(date)
    p date.strftime("%Y-%m-%d %I:%m:%S UTC")
    #   p 'in merch rev'
    #p "2012-03-25 09:54:09 UTC"
    p date
    #                       # todo may been to be Date.parse()
    # found_merchants = merchants.select { |merc  hant| merchant.invoices.created_at == date }
    # total_revenue_for_merchants(found_merchants)

   # binding.pry ; puts "This IS the pry you are looking for: #{self.class}"

    # fix find_all_by)_created_at
    #   1) change the test to pass in a ruby object
    #   2) maybe change the Invoice class to parse the date (right now its being stored as a string)

     p invoices = engine.invoice_repository.all.select { |invoice| invoice.created_at == date }
     p "#{invoices.size} ------------------------------------------------------------"
      success = invoices.select { |invoice|
         invoice.transactions.any? { |transaction|
         transaction.success?
         }
       }
   # binding.pry ; puts "This IS the pry you are looking for: #{self.class}"
    p "#{success.size} =================================================================="



    # filter invoices to only successful invoices
    # for each invoice
    #   only add it the new array if it has at least one successful transaction


  total_revenue = success
    total_revenue = success.reduce(0) do |total, invoice|

      if invoice.created_at == date
        total + invoice.invoice_items.reduce(0) do |sum, invoice_item|
          sum + invoice_item.total
        end
      else
        total
      end
    end
    total_revenue.to_d / 100
  end

  def total_revenue_for_merchants(merchants)
    # why was i sending merchants?
    paid_invoices = engine.invoice_repository.paid_invoices
    puts '-' * 70
   engine.total_revenue_for_all_invoices(paid_invoices).is_a? Array
  end
end





#engine.invoice_repository.paid_invoices
#merchants.select { |total_revenue| total_revenue.created_at == date }.map { |merchant| merchant.invoice }
