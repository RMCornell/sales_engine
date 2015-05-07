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

  def find_merchant_items_by_(id)
    engine.find_merchant_items_by_(id)
  end

  def find_merchant_invoices_by_(id)
    engine.find_merchant_invoices_by_(id)
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

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

  def find_merchant_revenue_by_(id)
    engine.find_merchant_revenue_by_(id)
  end

  def find_merchant_revenue_by_date_(date=nil, id)
    engine.find_merchant_revenue_by_date_(date, id)
  end

  def revenue(date)
    invoices = engine.invoice_repository.all
             .select { |invoice| invoice.created_at == date }
    paid_invoices = successful_transactions(invoices)
    engine.total_revenue_for_all_invoices(paid_invoices)
  end

  def successful_transactions(invoices)
    invoices.select { |invoice|
      invoice.transactions.any? { |transaction|
        transaction.successful? } }
  end

  def total_merchant_revenue
    invoices = engine.invoice_repository.all
    paid_invoices = successful_transactions(invoices)
    engine.total_revenue_for_all_invoices(paid_invoices)
  end

  def customers_with_pending_invoices(id)
    engine.customers_with_pending_invoices(id)
  end

  def most_revenue(x)
    merchants.max_by(x) { |merchant| merchant.revenue }
  end

  def most_items(x)
    merchants.max_by(x) do |merchant|
      paid_invoices = successful_transactions(merchant.invoices)
      paid_invoices.inject(0) do |total, invoice|
        total + invoice.invoice_items.inject(0) do |total, invoice_item|
          total + invoice_item.quantity
        end
      end
    end
  end
end
