class Activity < ActiveRecord::Base
	has_many :events
	has_many :hosts, through: :events
	has_many :locations, through: :events
end
