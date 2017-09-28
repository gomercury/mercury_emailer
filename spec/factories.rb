FactoryGirl.define do
	factory :template do
		name 				"RESERVATION_CONFIRMED"
		sendgrid_id "3b7ac025-f0d5-4540-baba-30e2b4c8a9e8"
	end

	factory :email do
		to 					Faker::Internet.email
		from 				Faker::Internet.email
		template_id FactoryGirl.create(:template).id
	end
end
