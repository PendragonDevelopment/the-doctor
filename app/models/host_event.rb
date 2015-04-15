# == Schema Information
#
# Table name: host_events
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  host_id    :integer
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HostEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :host
end
