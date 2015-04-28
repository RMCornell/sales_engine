require_relative 'test_helper'

class ParserTest < Minitest::Test

  def setup
    @file = '../data/customers.csv'
  end

  def test_parser_can_load_a_file
    assert CsvParser.parse(@file)
  end

  def test_parser_raises_error_if_file_is_not_found
    #todo how to make this work?
    skip
    CsvParser.parse('./my/file')
    assert_raises IOError, './file/not/found not found!'
  end
end
