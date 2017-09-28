require 'rails_helper'

RSpec.describe Api::V1::EmailsController, type: :controller do
	before(:each) do
		allow(controller).to receive(:restrict_access)
	end

	let(:email) { FactoryGirl.create(:email) }
	let(:template) { FactoryGirl.create(:template) }

	describe "POST create" do
		context "with valid attributes" do
			it "creates a new email" do
				params = {
					template: {
						name: template.name,
					},
					to: email.to,
					from: email.from,
				}
				expect {
					post :create, params: params
				}.to change(Email, :count).by(1)
				expect(response).to have_http_status(:created)
				expect(JSON.parse(response.body)["status"]).to eq("pending")
			end
		end

		context "with invalid 'to' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: template.name,
					},
					to: "invalid email",
					from: email.from,
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end

		context "with invalid 'from' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: template.name,
					},
					to: email.to,
					from: "invalid email",
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end

		context "with invalid template 'name' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: "invalid template name",
					},
					to: email.to,
					from: email.from,
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end
	end
end
