require 'json'
require 'base64'
require 'net/http'
require 'base64'
require 'hmac-sha1'

# Keys
APP_KEY = '/7s9n3g5eh0u'
AUTH_KEY = 'Uw78B5n5j0Zv0Ph4'
DEFAULT_AUTH_KEY = 'DEiygeist'

# URI
BASE_URI = 'https://www.digit-eyes.com/gtin/v2_0/'
LANG = "en"

# generates a signature for digit-eyes api calls
# Returns: Base64 encoded HMAC-SHA1 hash of *key + UPC/EAN code)
def generate_signature(key, upc_code)

  hmac = (HMAC::SHA1.new(key) << upc_code).digest
  return  Base64.strict_encode64(hmac)
  
end

# create full query params hashtable for the digit-eye api.
def create_query_params(app_key, upc_code, field_names, language)
  return { 
    "upcCode" => upc_code, 
    "field_names" => field_names, 
    "language" => language,
    "app_key" => app_key,
    "signature" => generate_signature(app_key, upc_code)
  }
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
    uri = URI(BASE_URI)
    query_params = create_query_params_keyless(app_key, upc_code, field_names, language)
    uri.query = URI.encode_www_form(query_params)

    response = Net::HTTP.get_response(uri)
    return response.body
end

def lambda_handler(event:, context:) 

    upc_code = "9310022130908"
    field_names = "all"

    return lookup_upc(DEFAULT_AUTH_KEY, upc_code, field_names, LANG)
end

#puts lambda_handler(event: '', context: '')