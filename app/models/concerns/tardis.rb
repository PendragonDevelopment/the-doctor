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
	
	def get_schedule_block(schedule_block)
	end

	def get_appointments_on_schedule_block(schedule_block)
	end

	def get_appointment_on_schedule_block(schedule_block, appointment)
	end

	def create_schedule_block(schedule_block_params)
	end

	def update_schedule_block(schedule_block, schedule_block_params)
	end

	def delete_schedule_block(schedule_block)
	end

	private

		def authorize_application
			OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)
		end

		def set_token(client)
			client.client_credentials.get_token
		end

end