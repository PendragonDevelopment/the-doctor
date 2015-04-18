module Tardis
  require 'oauth2'

# all of the above is necessary to set client (put into irb for practice)
require 'oauth2'
client_id = 'e82afee54cfebbc66ac2448a9e696ead53f126e053d9473979cbff9f952c157d'
client_secret = 'f64ca364bd8753239a066aaaa87b08ce8435431da661c1b9fe1a6ef8c2767a11'
redirect_uri = 'urn:ietf:wg:oauth:2.0:oob'
site = 'https://tardis-scheduler.herokuapp.com'
client = OAuth2::Client.new(client_id, client_secret, :site => site)

# this will use the newly created client and return a url with the authorization code
client.auth_code.authorize_url(:redirect_uri => redirect_uri)

# set the code as a variable here
code = 'd9248d4a730fa35822fe1e646cc72204ed9fcd17acc7c88fd8b3ccaf2f746725'

# create a token here
token = client.auth_code.get_token(code, :redirect_uri => redirect_uri)

# make a request
token.get('/api/v1/schedule_blocks')
token.get('/api/v1/appointments')

# to create a schedule_block
token.post('/api/v1/schedule_blocks', opts = {params: {host_id:1, event_id:1, location_id:1, start_time:'2016-02-03 10:00:00', end_time:'2016-02-03 11:00:00', reservation_min:1, reservation_max:4, status:'full'}})

# to retrieve a schedule_block by :id
token.get('/api/v1/schedule_blocks/1')

# to update a schedule_block by :id
token.put('/api/v1/schedule_blocks/1', opts = { params: {host_id:4}})

# to delete a schedule_block by :id
token.delete('/api/vi/schedule_blocks/1')

# to return a list of appointments for a given schedule_block
token.get('/api/v1/schedule_blocks/1/appointments')

# to create a new appointment for a given schedule_block
token.post('/api/v1/schedule_blocks/1/appointments', opts = { params: {schedule_block_id:1, attendee:1, status:'booked'}}

# to retrieve an appointment by :id
token.get('/api/v1/schedule_blocks/1/appointments/1')


  desc "Creates a new Appointment with the given parameters for a given Schedule Block"
    post ":id/appointments" do
      @schedule_block = ScheduleBlock.find(params[:id])
      @appointment = @schedule_block.appointments.create(params)
      return @appointment.to_json
    end


==========================================================================================

client = OAuth2::Client.new('client_id', 'client_secret', :site => 'https://example.org')

client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
# => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
response.class.name
# => OAuth2::Response
end