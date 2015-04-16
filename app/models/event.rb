# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
	has_many :transactions
	belongs_to :location
	belongs_to :activity
	belongs_to :host
end
