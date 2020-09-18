require 'json'
require 'test/unit'
require 'mocha/test_unit'

require_relative '../../functions/utils/digiteyes_utils'
require_relative '../../functions/request_product_details/app'

class RequestProductDetailsTEst < Test::Unit::TestCase

  def event
    {
      key : 'DEiygeist'
      upc_code : "9310022130908"
      signature : generate_signature(auth_key, product_code)
    }.to_json
  end

  def expected_result
    {
      brand : "Schmackos",
      description : "Schmackos Snacks Strapz Chicken 180G",
      formattedNutrition : null,
      gcp : {
         address : "PO Box 397",
         address2 : null,
         city : "WYONG",
         company : "Mars Australia Pty Ltd",
         contact : null,
         country : "AU",
         fax : null,
         gcp : "9310022",
         gln : "9377778034294",
         phone : null,
         postal_code : "2259",
         state : "Ma"
      },
      gcp_gcp : "9310022",
      image : "https://www.jbmetro.com.au/media/catalog/product/cache/1/image/7e1aea6e2c08539247f9eb908fe75c5e/7/4/74761.jpg",
      ingredients : null,
      language : "en",
      manufacturer : {
      address : null,
      address2 : null,
      city : null,
      company : null,
      contact : null,
      country : null,
      phone : null,
        postal_code : null,
        state : null
     },
     nutrition : null,
      product_web_page : "https://shop.stefmar.com.au/schmackos/schmackos-snacks-strapz-chicken-180g",
      return_code : "0",
      return_message : "Success",
      uom : "180 G",
      upc_code : "9310022130908",
      usage : "schmackos chicken strapz 180 G | Schmackos dog treat&&litter | pet supplies| Product Information: High quality treats for your pet from the Schmackos range",
      website : "shop.stefmar.com.au/"
    }
  end

  def test_lambda_handler
    HTTParty.expects(:get).with('http://checkip.amazonaws.com/').returns(mock_response)
    assert_equal(lambda_handler(event: event, context: ''), expected_result)
  end

end