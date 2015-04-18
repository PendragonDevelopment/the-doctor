module Tardis

	extend ActiveSupport::Concern

	def authorize_and_set_token
		@client = authorize_application
		@token = set_token(@client)
	end

	#Schedule Block methods
	def get_schedule_blocks
		JSON.parse(@token.get('/api/v1/schedule_blocks').body)
	end

	#get /schedule_blocks
	#get /schedule_blocks/:id
	#get /schedule_blocks/:id/appointments
	#get /schedule_blocks/:id/appointments/:apt_id

	#post /schedule_blocks

	#put /schedule_blocks/:id

	#delete /schedule_blocks/:id

	private

		def authorize_application
			OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)
		end

		def set_token(client)
			client.client_credentials.get_token
		end

end