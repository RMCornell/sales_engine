class TransactionRepository
  attr_reader :transaction_data, :engine, :transactions

  def initialize(transaction_data, engine)
    @engine = engine
    @transaction_data = transaction_data
    @transactions = load_transactions(transaction_data)
  end

  def load_transactions(transaction_data)
    transaction_data.map do |row|
      Transaction.new(row, self)
    end
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
