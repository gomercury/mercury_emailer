require 'rails_helper'

RSpec.describe Template, type: :model do
  it "should have a valid factory" do
		template = FactoryGirl.create(:template)
		expect(template).to be_valid
	end
end
