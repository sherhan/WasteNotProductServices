require 'json'
require 'test/unit'

require_relative '../../functions/utils/digiteyes_utils'
require_relative '../../functions/request_product_details/app'

class RequestProductDetailsTest < Test::Unit::TestCase

  def test_lambda_handler
    # HTTParty.expects(:get).with('http://checkip.amazonaws.com/').returns(mock_response)

    expected_str = File.read("./product.json")
    expected = JSON.parse(expected_str)
    
    result_str = lambda_handler(event: '', context: '')
    result = JSON.parse(result_str)

    assert_equal(expected, result)

  end

end