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
    "#<#{self.class}: id:#{@id.inspect} invoice_id: #{@invoice_id.inspect} credit_card_number: #{@credit_card_number.inspect} credit_card_expiration_date: #{@credit_card_expiration_date.inspect} result: #{@result.inspect} created_at: #{@created_at.inspect} updated_at: #{@updated_at.inspect}>"
  end

  def invoice
    repository.find_invoice_by_(id)
  end
end


