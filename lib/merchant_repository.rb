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
    #p date.strftime("%Y-%m-%d %I:%m:%S UTC")

    invoices = engine.invoice_repository.all.select { |invoice| invoice.created_at == date }

    total_revenue = invoices.select { |invoice|
      invoice.transactions.any? { |transaction|
        transaction.success?
      }
    }
    engine.total_revenue_for_all_invoices(total_revenue)
  end
end
