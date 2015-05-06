# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  host_id     :integer
#  location_id :integer
#  rate        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#



FactoryGirl.define do

  factory :event do
    activity
    host
    location
    event_rate 500

    factory :event_alternate do 
      association :activity, factory: :activity, title: 'T. Hardy Morris Concert'
    end

    factory :invalid_event do
      rate nil
    end
  end
  
end
