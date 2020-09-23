require 'json'
require 'test/unit'

require_relative '../../functions/request_product_details/app'

class RequestProductDetailsTest < Test::Unit::TestCase

  def setup
    # Test key/[code, signature] pairs
    # Key => [upc_code, signature]
    @signature_dict = {
      "bQeThWmZq4t7w!z%" => ["9310022130908", "K7eaE7mNhdJUmc0XvsJidgpaxnk="], 
      "G+KbPeShVmYq3t6w" => ["9310022130908", "S8KNcqXMpcrIzY1w2CeTsFphZNc="], 
      "%D*G-KaPdSgVkYp3" => ["9310022130908", "ZHxWxgGK3m+pg9NPaQDB5l4yLHc="], 
      "x!A%C*F-JaNdRgUk" => ["9310022130908", "Y9kEm0JM9EHrWjZx9IUCVS3BZvI="], 
      "4t7w!z$C&F)J@NcR" => ["9310022130908", "LuopWMQ1EVRP82F5b383hL/eziU="], 
      "mYq3t6w9z$B&E)H@" => ["9310022130908", "/KzWYMyrjYAk8GgIQNT1A1vD+iM="], 
      "SgVkYp3s6v9y$B?E" => ["9310022130908", "7dgxJ7lkNZehHR9UrFFrIuob+nc="], 
      "aNdRgUkXp2s5v8y/" => ["9310022130908", "SHIoCPoyYHCH67Mw+Uz2k7K1PzE="],
    }
    
    # Single set of query params
    @key = "G+KbPeShVmYq3t6w"
    @upc_code = "9310022130908"
    @signature = "S8KNcqXMpcrIzY1w2CeTsFphZNc="
    @language = 'en'
    @field_names = "all"
    
    # Query params hashtable
    @fields = {
      "app_key" => @key,
      "upcCode" => @upc_code,
      "field_names" => @field_names,
      "language" => @language,
      "signature" => @signature
    }
  end

  def teardown
    ## Nothing really
  end

  ############ UTIL TESTS #####################################

  def test_generate_signature_single
    assert_match(@signature, generate_signature(@key, @upc_code))
  end 

  def test_generate_signature_multi
    # Iterate through signature_dict and assert
    @signature_dict.each do |key, value_pair|
      assert_match(value_pair[1], generate_signature(key, value_pair[0]))
    end
  end 

  def test_create_query_params
    assert_equal(@fields, create_query_params(@key, @upc_code, @field_names, @language))
  end

  def test_create_query_params_keyless
    fields_without_key = @fields
    fields_without_key.delete("app_key")
    assert_equal(fields_without_key, create_query_params_keyless(@key, @upc_code, @field_names, @language))
  end

  ########## HANDLER TESTS ########################################

  def test_lambda_handler
   
    # Read expected output JSON file
    this_files_dir = File.expand_path(File.dirname(__FILE__)) # directory of this file
    expected_str = File.read(this_files_dir + "/product.json")
    expected = JSON.parse(expected_str)
    
    # execute test
    result_str = lambda_handler(event: '', context: '')
    result = JSON.parse(result_str)

    # assert
    assert_equal(expected, result)
  end

end