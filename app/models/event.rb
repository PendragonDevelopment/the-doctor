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

	@@token ||= nil

	def self.generate_token
		authorized_application = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => SITE_URL)
		@@token = authorized_application.client_credentials.get_token
	end

	def token
		@@token
	end

end
