FactoryGirl.define do
	factory :appointment do
		skip_create

		factory :invalid_appointment do
		end
		
	end
end