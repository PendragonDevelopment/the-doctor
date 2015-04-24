# == Schema Information
#
# Table name: host_events
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  host_id    :integer
#  rate       :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_host_events_on_event_id  (event_id)
#  index_host_events_on_host_id   (host_id)
#

FactoryGirl.define do
  factory :host_event do
    event nil
host nil
rate 1
  end

end
