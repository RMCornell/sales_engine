class Transaction

  attr_reader :repository,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction, repository)
    @repository                  = repository
    @id                          = transaction[:id].to_i
    @invoice_id                  = transaction[:invoice_id].to_i
    @credit_card_number          = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result                      = transaction[:result]
    @created_at                  = transaction[:created_at]
    @updated_at                  = transaction[:updated_at]
  end

  def inspect
    "#<#{self.class}: id:#{@id.inspect}>"
  end

  ### transactions(invoice_id) --> invoice(id) --> transactions#invoice

  def invoice
    repository.find_invoice_by_(invoice_id)
  end

  def successful?
    result == 'success'
  end

  def pending
    result == 'failed'
  end
end


