class TransactionRepository
  attr_reader :engine, :transactions

  def initialize(engine)
    @engine = engine
  end

  def load_transactions(dir)
    file = Parser.parse("#{dir}/transactions.csv")
    @transactions = file.map { |row| Transaction.new(row, self) }
  end

  def inspect
    "#<#{self.class}: #{@transactions.size} rows>"
  end






















  def all
    @transactions
  end

  def random
    # todo random
  end

  def find_by_id(id)
    # todo find_by_id
  end

  def find_by_invoice_id(invoice_id)
    @transactions.select { |transaction| transaction.invoice_id == invoice_id }
  end














  def find_by_credit_card_number(credit_card_number)
    # todo
  end

  def find_by_credit_card_expiration_date(exp_date)
    # todo
  end

  def find_by_result
    #todo
  end

  def find_by_created_at(time)
    # todo
  end

  def find_by_updated_at(time)
    # todo
  end

  def find_all_by_id(id)
    # todo
  end

  def find_all_by_invoice_id(id)
    # todo
  end

  def find_all_by_credit_card_number(credit_card_number)
    # todo
  end

  def find_all_by_credit_card_expiration_date(exp_date)
    #todo
  end

  def find_all_by_result
    #todo
  end
  
  def find_all_by_created_at(time)
    #todo 
  end

  def find_all_by_updated_at(time)
    # todo
  end
end
