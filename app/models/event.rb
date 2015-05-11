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
		new_location = new_location_params[:title]
		if new_location.empty? # Do nothing, the new location field was blank
			return 
		else # Do something, new location field was filled in
			if Location.where(title: new_location).empty? # If a location doesn't already exist with the same title, create a new location
				new_location_object = self.create_location(title: new_location)
				self.update_attributes(location_id: new_location_object.id)
			else # A location with this title already exists, don't allow a new one to be created
				return false
			end
		end
	end

	def new_activity_from_event_form(new_activity_params)
		new_activity = new_activity_params[:title]
		if new_activity.empty?
			return
		else
			if Activity.where(title: new_activity).empty?
				new_activity_object = self.create_activity(title: new_activity)
				self.update_attributes(activity_id: new_activity_object.id)
			else
				return false
			end
		end
	end

end
