require 'json'
require 'base64'
require 'hmac-sha1'
require 'net/http'

# URI
BASE_URI = 'https://www.digit-eyes.com/gtin/v2_0/'
LANG = "en"

# generates a signature for digit-eyes api calls
# Returns: Base64 encoded HMAC-SHA1 hash of *key + UPC/EAN code)
def generate_signature(key, upc_code)

    hmac = (HMAC::SHA1.new(key) << upc_code).digest
    return  Base64.strict_encode64(hmac)
    
end

# create query params hashtable for the digit-eye api without app_key included
def create_query_params_keyless(app_key, upc_code, field_names, language)
    return { 
      "upcCode" => upc_code, 
      "field_names" => "all", 
      "language" => "en",
      "signature" => generate_signature(app_key, upc_code)
    }
  end  

def lookup_upc(app_key, upc_code, field_names, language)
    # Create URI
    uri = ENV['BASE_URI']
    query_params = create_query_params_keyless(app_key, upc_code, field_names, language)
    uri.query = URI.encode_www_form(query_params)

    response = Net::HTTP.get_response(uri)
    return response.body
end

def lambda_handler(event:, context:) 
    # Initialise inputs
    app_key = ENV['DIGITEYES_KEY']
    lang = ENV['LANGUAGE']
    upc_code = "9310022130908"
    field_names = "all"

    return lookup_upc(app_key, upc_code, field_names, lang)
end

#puts lambda_handler(event: '', context: '')