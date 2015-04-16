class Event < ActiveRecord::Base
	has_many :transactions
	belongs_to :location
	belongs_to :activity
	belongs_to :host
end
