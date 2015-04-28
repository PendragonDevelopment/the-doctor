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

	validates :title, presence: true

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags, :genres, :subjects, :trip_type
end
