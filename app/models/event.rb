# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :category
  has_many :host_events
  acts_as_taggable
  acts_as_taggable_on :categories
end
