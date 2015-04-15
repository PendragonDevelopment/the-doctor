# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :event do
    title "MyString"
category nil
  end

end
