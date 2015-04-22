FactoryGirl.define do
	factory :schedule_block do
		skip_create

		start_time DateTime.now
		end_time DateTime.now + 1
		reservation_min 2
		reservation_max 10
		status 0

		factory :invalid_schedule_block do
			reservation_min nil
			reservation_max nil
		end

	end
end