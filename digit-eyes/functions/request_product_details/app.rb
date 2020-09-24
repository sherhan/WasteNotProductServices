require 'json'
require 'base64'
require 'hmac-sha1'
require 'net/http'

require_relative '../utils/digiteyes_utils.rb'

def lookup_upc(app_key, upc_code, field_names, language)
    # Create URI
    uri = URI(ENV["BASE_URI"])
    query_params = create_query_params_keyless(app_key, upc_code, field_names, language)
    uri.query = URI.encode_www_form(query_params)

    response = Net::HTTP.get_response(uri)
    return response.body
end

def lambda_handler(event:, context:) 
    # Initialise inputs
    app_key = ENV["DIGITEYES_KEY"]
    lang = ENV["LANGUAGE"]
    upc_code = "9310022130908"
    field_names = "all"

    return lookup_upc(app_key, upc_code, field_names, lang)
end

# puts lambda_handler(event: '', context: '')