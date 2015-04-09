class Host < ActiveRecord::Base
  belongs_to :user
  has_many :host_events
end
