require 'csv'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(invoice, repository)
    #@invoice        = invoice
    @repository     = repository
    @id             = invoice[:id].to_i
    @customer_id    = invoice[:customer_id].to_i
    @merchant_id    = invoice[:merchant_id].to_i
    @status         = invoice[:status]
    @created_at     = invoice[:created_at]
    @updated_at     = invoice[:updated_at]
  end

end

class Parser

  def self.parse(file)
    if File.exist?(file)
      CSV.read(file, headers: true, header_converters: :symbol)
    else
      return "file not found"
      # todo how to make this work
      #raise IOError, "#{file} not found!"
    end
  end
end





#file = CSV.open('./test/fixtures/invoices.csv', headers: true, header_converters: :symbol)

file = Parser.parse('./test/fixtures/invoices.csv')

@invoices = file.map do |row|
  Invoice.new(row, self)
end

R
@invoices.each do |invoice|
  p invoice.id
end


#p @invoices.select { |invoice| invoice.id < 5 }


p @invoices.detect { |invoice| invoice.id == 10 }R

