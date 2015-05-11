CLIENT_ID='5896c9d93c5f32b342c3ee25d287bdd145c623fc243f692d2ae472666f1fe538'
CLIENT_SECRET='c4306975a94428c9474c6e766e9711aecf63db8f831274a0ab2ab1c39ebc013d'
SITE_URL='https://tardis-scheduler.herokuapp.com'

authorized_application = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)

begin
  $token = authorized_application.client_credentials.get_token
rescue
  puts "Token could not be generated"
end
