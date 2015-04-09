class HostEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :host
end
