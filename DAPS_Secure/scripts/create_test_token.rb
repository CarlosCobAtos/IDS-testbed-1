# frozen_string_literal: true

require 'openssl'
require 'jwt'
require 'json'

##
# NOTE:
# The client_id in config/clients.yml must match the 'iss' and 'sub' claim
# of the JWT you generate.
# Do not forget to configure the 'certfile' of your client so that
# omejdn can find you public key which corrsponds to the private key you
# use to sign this JWT.
#
# The 'aud' claim MUST correspond to the HOST environment parameter
# or the 'host' value in the config/omejdn.yml.
# Alternatively, if omejdn is started with the OMEJDN_JWT_AUD_OVERRIDE
# environment variable you must use that value instead.
#

CLIENTID = 'testidsa10'

def load_key
  if File.exist? "#{CLIENTID}.key"
    filename = "#{CLIENTID}.key"
    rsa_key = OpenSSL::PKey::RSA.new File.read(filename)
  else
    rsa_key = OpenSSL::PKey::RSA.new 2048
    pfile = File.new "#{CLIENTID}.key", File::CREAT | File::TRUNC | File::RDWR
    pfile.write(rsa_key.to_pem)
    pfile.close
  end
  rsa_key
end

# Only for debugging!
client_rsa_key = load_key
payload = {
  'iss' => 'C6:3E:DE:2B:E7:00:3F:2A:84:C0:1D:BF:41:2C:E6:65:82:44:E8:AC:keyid:CB:8C:C7:B6:85:79:A8:23:A6:CB:15:AB:17:50:2F:E6:65:43:5D:E8',
  'sub' => 'C6:3E:DE:2B:E7:00:3F:2A:84:C0:1D:BF:41:2C:E6:65:82:44:E8:AC:keyid:CB:8C:C7:B6:85:79:A8:23:A6:CB:15:AB:17:50:2F:E6:65:43:5D:E8',
  'exp' => Time.new.to_i + 36000,
  'nbf' => Time.new.to_i,
  'iat' => Time.new.to_i,
  'aud' => 'idsc:IDS_CONNECTORS_ALL' # The omejdn host or OMEJDN_JWT_AUD_OVERRIDE value
}
token = JWT.encode payload, client_rsa_key, 'RS256'
puts token
