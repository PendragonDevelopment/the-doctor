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
	
	include Tardis

	has_many :transactions
	belongs_to :location
	belongs_to :activity
	belongs_to :host

	validates :rate, presence: true

end
