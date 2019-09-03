require 'sinatra'
require 'aws-sdk'
require 'webrick/https'
require 'openssl'
require 'json'

ssl_options = {
  SSLEnable: true,
  SSLCertificate: OpenSSL::X509::Certificate.new(File.open('./localhost.crt').read),
  SSLPrivateKey:  OpenSSL::PKey::RSA.new(File.open('./localhost.pem').read)
}
set :server_settings, ssl_options
set :identity_id,  "ap-northeast-1:c9869592-b25a-40c7-8621-63ea7740e813"

get '/' do
  'Hello world!'
end

get '/id_pool' do
  client = Aws::CognitoIdentity::Client.new
  desc = client.describe_identity_pool({
  identity_pool_id: settings.identity_id, # required
  })
  role = client.get_identity_pool_roles({
  identity_pool_id: settings.identity_id, # required
  })
  JSON.generate(role) + JSON.generate(desc)
end

post '/getid' do
  client = Aws::CognitoIdentity::Client.new
  puts params["SAMLResponse"]
  resp = client.get_id({
    account_id: "500718865639",
    identity_pool_id: settings.identity_id,
    logins: {
      "arn:aws:iam::500718865639:saml-provider/OsamuGsuiteAuth" => params["SAMLResponse"],
    },
  })
  resp.to_json
end

