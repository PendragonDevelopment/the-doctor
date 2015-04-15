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

FactoryGirl.define do
  factory :host_event do
    event nil
host nil
rate 1
  end

end
