require 'json'
require 'base64'
require 'net/http'
require 'base64'
require 'hmac-sha1'

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
    uri = URI(ENV["BASE_URI"])
    query_params = create_query_params_keyless(app_key, upc_code, field_names, language)
    uri.query = URI.encode_www_form(query_params)

    response = Net::HTTP.get_response(uri)
    return response.body
end

def lambda_handler(event:, context:) 

    app_key = ENV["DIGITEYES_KEY"]
    lang = ENV["LANGUAGE"]
    upc_code = event["upc_code"]
    field_names = event["field_names"]

    return lookup_upc(app_key, upc_code, field_names, lang)
end

