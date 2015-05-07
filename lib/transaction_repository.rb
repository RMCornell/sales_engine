require_relative 'transaction'

class TransactionRepository
  include Enumerable
  attr_reader :engine, :trans

  def initialize(engine, dir)
    @engine = engine
    load_transactions(dir)
  end

  def load_transactions(dir)
    file = Parser.parse("#{dir}/transactions.csv")
    @trans = file.map { |row| Transaction.new(row, self) }
  end

  def each(&block)
    @trans.each(&block)
  end

  def inspect
    "#<#{self.class}: #{@trans.size} rows>"
  end

  # transactions#invoice
  def find_invoice_by_(invoice_id)
    engine.find_invoice_by_(invoice_id)
  end

  def all
    trans
  end

  def random
    trans.sample
  end

  # //---------- Find_by Methods ----------//
  def find_by_id(id)
    trans.detect { |trans| id == trans.id }
  end

  def find_by_invoice_id(invoice_id)
    trans.detect { |trans| invoice_id == trans.invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    trans.detect{ |trans| credit_card_number == trans.credit_card_number}
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    trans.detect{ |trans| credit_card_expiration_date ==
      trans.credit_card_expiration_date}
  end

  def find_by_result(result)
    trans.detect {|trans| result == trans.result}
  end

  def find_by_created_at(created_at)
    trans.detect {|trans| created_at == trans.created_at}
  end

  def find_by_updated_at(updated_at)
    trans.detect {|trans| updated_at == trans.updated_at}
  end

  # //---------- Find_by_all Methods ----------//
  def find_all_by_id(id)
    trans.select {|trans| id == trans.id}
  end

  def find_all_by_invoice_id(invoice_id)
    trans.select {|trans| invoice_id == trans.invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    trans.select {|trans| credit_card_number == trans.credit_card_number}
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    trans.select {|trans| credit_card_expiration_date ==
      trans.credit_card_expiration_date}
  end

  def find_all_by_result(result)
    trans.select {|trans| result == trans.result}
  end

  def find_all_by_created_at(created_at)
    trans.select {|trans| created_at == trans.created_at}
  end

  def find_all_by_updated_at(updated_at)
    trans.select {|trans| updated_at == trans.updated_at}
  end

  # //---------- Business Logic ----------//

  def successful_transactions
      trans.select { |trans| trans.successful? }
  end

  def pending_transactions
      trans - successful_transactions
  end

  def add_transaction(invoice)
    trans << Transaction.new(invoice, self)
  end
end
