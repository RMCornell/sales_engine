class TransactionRepository
  include Enumerable
  attr_reader :engine, :transactions

  def initialize(engine, dir)
    @engine = engine
    load_transactions(dir)
    @transactions = []
  end

  def load_transactions(dir)
    file = Parser.parse("#{dir}/transactions.csv")
    @transactions = file.map { |row| Transaction.new(row, self) }
  end

  def each(&block)
    @transactions.each(&block)
  end

  def inspect
    "#<#{self.class}: #{@transactions.size} rows>"
  end

  # transactions#invoice
  def find_invoice_by_(invoice_id)
    engine.find_invoice_by_(invoice_id)
  end






  def all
    transactions
  end

  def random
    transactions.sample(1)
  end

# Find_by Methods

  def find_by_id(id)
    transactions.detect { |transaction| id == transaction.id }
  end

  def find_by_invoice_id(invoice_id)
    transactions.select { |transaction| invoice_id == transaction.invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.detect { |transaction| credit_card_number == transaction.credit_card_number}
  end

  def find_by_result(result)
    transactions.detect {|transaction| result == transaction.result}
  end

  def find_by_created_at(created_at)
    transactions.detect {|transaction| created_at == transaction.created_at}
  end

  def find_by_updated_at(updated_at)
    transactions.detect {|transaction| updated_at == transaction.updated_at}
  end

#Find_by_all Methods
  def find_all_by_id(id)
    transactions.select {|transaction| id == transaction.id}
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select {|transaction| invoice_id == transaction.invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select {|transaction| credit_card_number == transaction.credit_card_number}
  end

  def find_all_by_result(result)
    transactions.select {|transaction| result == transaction.result}
  end

  def find_all_by_created_at(created_at)
    transactions.select {|transaction| created_at == transaction.created_at}
  end

  def find_all_by_updated_at(updated_at)
    transactions.select {|transaction| updated_at == transaction.updated_at}
  end

end






















