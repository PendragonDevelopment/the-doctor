# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Activity < ActiveRecord::Base
	has_many :events
	has_many :hosts, through: :events
	has_many :locations, through: :events
end
