require 'rails_helper'

RSpec.describe Email, type: :model do
	it "should have a valid factory" do
		email = FactoryGirl.create(:email)
		expect(email).to be_valid
	end

	describe ".pending" do
		it "should return emails with 'pending' status" do
			pending_email = FactoryGirl.create(:email, status: "pending")
			failed_email = FactoryGirl.create(:email, status: "failed")
			emails = Email.pending
			expect(emails.count).to eq(1)
			expect(emails.first).to eq(pending_email)
		end
	end

	describe ".failed" do
		it "should return emails with 'failed' status" do
			pending_email = FactoryGirl.create(:email, status: "pending")
			failed_email = FactoryGirl.create(:email, status: "failed")
			emails = Email.failed
			expect(emails.count).to eq(1)
			expect(emails.first).to eq(failed_email)
		end
	end
end
