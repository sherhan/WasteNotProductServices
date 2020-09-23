require 'json'
require 'test/unit'

require_relative '../../functions/utils/digiteyes_utils'
require_relative '../../functions/request_product_details/app'

class RequestProductDetailsTest < Test::Unit::TestCase

  def test_lambda_handler
    # Read expected output JSON file
    this_files_dir = File.expand_path(File.dirname(__FILE__)) # directory of this file
    expected_str = File.read(this_files_dir + "/product.json")

    expected = JSON.parse(expected_str)
    
    # execute test
    result_str = lambda_handler(event: '', context: '')
    result = JSON.parse(result_str)

    # assert
    assert_equal(expected, result)
  end

end