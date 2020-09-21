# utils for digit-eyes api requests
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
