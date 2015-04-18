# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  latitude    :string
#  longitude   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :location do
  	title "Your Mom's House"
  	description "The house where your momma lives at."
  	latitude "48.8582"
  	longitude "2.2945"
    
    factory :invalid_location do
    	title nil
    end
  end

end
