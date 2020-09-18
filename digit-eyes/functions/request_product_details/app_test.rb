require 'json'
require 'httparty'
require_relative '../utils/digiteyes_utils'

LANG = "en"
APP_KEY = '/7s9n3g5eh0u'
#AUTH_KEY = 'Uw78B5n5j0Zv0Ph4'
AUTH_KEY = 'DEiygeist'

#def lambda
#def lambda_handler(event:, context:) 

    # Initialise inputs
    app_key = ""
    product_code = "9310022130908"
    field_names = "all"

    # Create query params
    query_params = create_query_params_keyless(AUTH_KEY, product_code, field_names, LANG)

    # Execute rest request
    response = HTTParty.get("https://www.digit-eyes.com/gtin/v2_0/", :query => query_params)
 
    puts response.body
   { statusCode: response.code, body: response.body }

