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

  def invoice(invoice_id)
    repository.find_by_invoice_id(invoice_id)
  end
end


