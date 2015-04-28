require 'csv'

require_relative 'csv_parser'

#require_relative 'merchant'
#require_relative 'merchant_repository'


class SalesEngine
  def startup
    return 'vroom!'
  end
end


if __FILE__ == $0
  engine = SalesEngine.new
  engine.startup
end
