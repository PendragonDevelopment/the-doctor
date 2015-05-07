# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime
#  updated_at               :datetime
#  first_name               :string
#  role                     :integer
#  last_name                :string
#  username                 :string
#  stripe_customer_id       :string
#  host_id                  :integer
#  profile_pic_file_name    :string
#  profile_pic_content_type :string
#  profile_pic_file_size    :integer
#  profile_pic_updated_at   :datetime
#

FactoryGirl.define do
  factory :user do
  	first_name "Bob"
  	last_name "McUser"
    sequence(:username) {|n| "Test User #{n}"}
    sequence(:email) {|n| "test-#{n}@example.com"}
    password "please123"
    role 0

    trait :admin do
      role 2
    end
  end
end
