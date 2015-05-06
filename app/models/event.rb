# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  host_id     :integer
#  location_id :integer
#  rate        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base

	has_many :transactions
	belongs_to :location
	belongs_to :activity
	belongs_to :host
	validates :event_rate, presence: true
	validates :host_id, presence: true
	validates :activity_id, presence: true
	validates :location_id, presence: true

	@@token ||= nil

	def self.generate_token
		authorized_application = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)
		@@token = authorized_application.client_credentials.get_token
	end

	def token
		@@token
	end

	#Schedule Block methods
	def get_schedule_blocks
		token_check
		JSON.parse(@@token.get('/api/v1/schedule_blocks').body)
	end

	def get_schedule_block(schedule_block_id)
		token_check
		JSON.parse(@@token.get("/api/v1/schedule_blocks/#{schedule_block_id}").body)
	end

	def get_appointments_on_schedule_block(schedule_block_id)
		token_check
		JSON.parse(@@token.get("/api/v1/schedule_blocks/#{schedule_block_id}/appointments").body)
	end

	#I think this method could be done better.
	def get_appointment_on_schedule_block(schedule_block_id, appointment_id)
		token_check
		JSON.parse(@@token.get("/api/v1/schedule_blocks/#{schedule_block_id}/appointments/#{appointment_id}").body)
	end

	def create_schedule_block(schedule_block_params)
		token_check
		@@token.post("/api/v1/schedule_blocks", wrap_params(schedule_block_params))
	end

	def update_schedule_block(schedule_block_id, schedule_block_params)
		token_check
		@@token.put("/api/v1/schedule_blocks/#{schedule_block_id}", wrap_params(schedule_block_params))
	end

	def delete_schedule_block(schedule_block_id)
		token_check
		@@token.delete("/api/v1/schedule_blocks/#{schedule_block_id}")
	end

	# Appointment Methods

	def get_appointments
		token_check
		JSON.parse(@@token.get('/api/v1/appointments').body)
	end

	def update_appointment(appointment_id, appointment_params)
		token_check
		@@token.put("/api/v1/appointments/#{appointment_id}", wrap_params(appointment_params))
	end

	def delete_appointment(appointment_id)
		token_check
		@@token.delete("/api/v1/appointments/#{appointment_id}")
	end


	private

		def token_check
			if @@token.nil?
				Event.generate_token
			end
		end

		def wrap_params(basic_params)
			result_hash = {
				:params => basic_params
			}
		end

end
