require_relative 'test_helper'

class ParserTest < Minitest::Test

  def setup
    @file = './test/fixtures/customers.csv'
  end

  def test_parser_can_load_a_file
    assert Parser.parse(@file)
  end

  def test_parser_raises_error_if_file_is_not_found
    assert_equal "file not found!", Parser.parse('./my/file')
  end
end
