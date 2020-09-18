# utils for digit-eyes api requests
require 'base64'
require 'openssl'
require 'net/http'

# generates a signature for digit-eyes api calls
# Returns: Base64 encoded HMAC-SHA1 hash of *key + UPC/EAN code)
def generate_signature(key, upc_code)

  digest = OpenSSL::Digest.new('sha1')
  hmac = OpenSSL::HMAC.digest(digest, key, upc_code)

  return Base64.strict_encode64(hmac)
  
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

# compose a digi-eyes uri with app_key query param included
# i.e. https://www.digit-eyes.com/gtin/v2_0/?upcCode=9312353001872 &field_names=all&language=en&app_key=G+KbPeShVmYq3t6w&signature=S8KNcqXMpcrIzY1w2CeTsFphZNc=
#
def create_digiteyes_uri(app_key = "", upc_code, field_names, language, signature) 

  # base URI
  uri = URI('https://www.digit-eyes.com/gtin/v2_0/')

  # query params from inputs
  query_params = { 
    "upcCode" => upc_code, 
    "field_names" => field_names, 
    "language" => language, 
    "signature" => signature
  }
  
  # add app_key to query_params if provided
  if(app_key != "")
    query_params.store("app_key", app_key)
  end

  # create full query string from query params
  query_str = ""
  query_params.each do | key, value |
    query_str = query_str + key + "=" + value + "&" 
  end

  # remove trailing "&" and add to uri query
  uri.query = query_str.chomp("&")

  return uri

end
