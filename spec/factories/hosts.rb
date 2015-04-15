# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  rating         :integer
#  active         :boolean
#  bio            :string
#  user_id        :integer
#  birthdate      :date
#  status         :integer
#  resume         :string
#  direct_deposit :string
#  voided_check   :string
#  w9             :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :host do
    rating 1
active false
bio "MyString"
user nil
birthdate "2015-04-09"
status 1
resume "MyString"
direct_deposit "MyString"
voided_check "MyString"
w9 "MyString"
  end

end
