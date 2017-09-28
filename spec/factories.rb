FactoryGirl.define do
	factory :template do
		name 		Faker::RickAndMorty.character
		subject Faker::RickAndMorty.quote
		html 		Faker::RickAndMorty.quote
	end

	factory :email do
		to 					Faker::Internet.email
		from 				Faker::Internet.email
		template_id FactoryGirl.create(:template).id
	end
end
