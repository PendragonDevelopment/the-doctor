class Event < ActiveRecord::Base
  belongs_to :category
  has_many :host_events
end
