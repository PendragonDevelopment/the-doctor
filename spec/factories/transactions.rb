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
    title "The Doctor charge"
    payment_amount 520
		payment_date "2015-04-06"
		status 1
		transaction_record "MyString"
		association :user, factory: :user
		host_event
  end

end
