require 'json'
require 'httparty'
require_relative '../utils/digiteyes_utils'

APP_KEY = '/7s9n3g5eh0u'
AUTH_KEY = 'Uw78B5n5j0Zv0Ph4'
DEFAULT_AUTH_KEY = 'DEiygeist'
LANG = "en"

def lambda_handler(event:, context:) 

    # Initialise inputs
    field_names = "all"
    product_code = "9310022130908"

    # Create query params
    query_params = create_query_params_keyless(DEFAULT_AUTH_KEY, product_code, field_names, LANG)
    puts query_params

    # Execute rest request
    response = HTTParty.get("https://www.digit-eyes.com/gtin/v2_0/", :query => query_params)
 
    #puts response.body
   return { statusCode: response.code, body: response.body }

end

puts lambda_handler(event: '', context: '')