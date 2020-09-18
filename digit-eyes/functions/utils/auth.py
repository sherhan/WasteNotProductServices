import base64
import hashlib
import hmac

import base64
import hashlib
import hmac

def make_auth_token(upc_code, auth_key):
  sha_hash = hmac.new(auth_key, upc_code, hashlib.sha1)
  return base64.b64encode(sha_hash.digest())

def batch_auth_tokens(upc_code, keys):
  
  signature_dict = {}
  for key in keys:
    signature_dict[key] = str(make_auth_token(bytes(upc_code, 'utf-8'), bytes(key, 'utf-8')))
   
  return signature_dict

keys = [
      "bQeThWmZq4t7w!z%",
      "G+KbPeShVmYq3t6w", 
      "%D*G-KaPdSgVkYp3", 
      "x!A%C*F-JaNdRgUk", 
      "4t7w!z$C&F)J@NcR", 
      "mYq3t6w9z$B&E)H@", 
      "SgVkYp3s6v9y$B?E", 
      "aNdRgUkXp2s5v8y/", 
      "F)J@NcRfUjXn2r5u", 
      "$B&E)H@McQfTjWnZ"
]

auth_key1 = 'Uw78B5n5j0Zv0Ph4'
auth_key = "DEiygeist"
upc_code = "9310022130908"

key_bytes1 = bytes(auth_key1, 'utf8')
key_bytes = bytes(auth_key, 'utf8')
upc_code_bytes = bytes(upc_code, 'utf8')

sig_dict = batch_auth_tokens(upc_code, keys)

print('binary hash\n' + str(hmac.new(key_bytes1, upc_code_bytes, hashlib.sha1).digest()))
print('signature\n')
print(str(make_auth_token(upc_code_bytes, key_bytes1)))
print('\n')
print(batch_auth_tokens(upc_code, keys))