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
    rating 4
		active false
		user
		birthdate "1990-04-09"
		status 1
		resume "resume"
		direct_deposit "direct_depost"
		voided_check "voided_check"
		w9 "w9"

		bio "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate"
  
		factory :invalid_host do
		#	rating nil
		end
  end

end
