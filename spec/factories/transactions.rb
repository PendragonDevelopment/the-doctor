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
