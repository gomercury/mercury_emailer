require 'rails_helper'

RSpec.describe SendgridService, type: :service do
	before(:each) do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean
	end

	describe ".send_email" do
		it "should update email 'status' to 'succeeded'" do
			email = FactoryGirl.create(:email,
				to: "cheung.ying.lon@gmail.com",
				from: "cheung.ying.lon@gmail.com",
			)
			email = SendgridService.send_email(email)
			expect(email.status).to eq("succeeded")
			expect(email.error).to be_nil
		end
	end
end
