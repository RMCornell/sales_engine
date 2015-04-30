
require 'simplecov'
require 'csv'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/parser'
require_relative '../lib/sales_engine'

require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
