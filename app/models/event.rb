class Event < ActiveRecord::Base
  belongs_to :category
  has_many :host_events
  acts_as_taggable
  acts_as_taggable_on :categories
end
