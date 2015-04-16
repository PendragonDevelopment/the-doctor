# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :activity do
    title "Juggling Competition"

    factory :invalid_activity do
    	title nil
    end
  end

end
