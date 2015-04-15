# == Schema Information
#
# Table name: transactions
#
#  id                 :integer          not null, primary key
#  title              :string
#  payment_amount     :integer
#  payment_date       :date
#  status             :integer
#  transaction_record :string
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appointment_id     :integer
#

FactoryGirl.define do
  factory :transaction do
    title "MyString"
charge_amount 1
date "2015-04-06"
status 1
transaction_record "MyString"
user nil
host_event nil
  end

end
