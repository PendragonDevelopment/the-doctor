# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  latitude    :string
#  longitude   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ActiveRecord::Base
	has_many :events

	reverse_geocoded_by :latitude, :longitude, :address
	after_validation :reverse_geocode

	validates :title, presence: true
end
