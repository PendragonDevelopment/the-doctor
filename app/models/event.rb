# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  host_id     :integer
#  location_id :integer
#  event_rate  :integer
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


	def new_location_from_event_form(new_location_params)
		# This commented-out line is only necessary to make controller tests pass...
		# return false if new_location_params.nil?
		return false if new_location_params[:title].empty?
		location = Location.find_or_create_by(title: new_location_params[:title])
		self.update_attributes(location_id: location.id)
	end

	def new_activity_from_event_form(new_activity_params)
		# This commented-out line is only necessary to make controller tests pass...
		# return false if new_activity_params.nil?
		return false if new_activity_params[:title].empty?
		activity = Activity.find_or_create_by(title: new_activity_params[:title])
		self.update_attributes(activity_id: activity.id)
	end

end
