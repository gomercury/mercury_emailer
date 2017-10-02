require 'rails_helper'

RSpec.describe Api::V1::EmailsController, type: :controller do
	before(:each) do
		allow(controller).to receive(:restrict_access)
	end

	let(:email) { FactoryGirl.create(:email) }
	let(:template) { FactoryGirl.create(:template, name: "RESERVATION_CONFIRMED") }

	describe "POST create" do
		context "with valid attributes" do
			it "creates a new email" do
				params = {
					template: {
						name: template.name,
					},
					email: {
						to: email.to,
						from: email.from,
					},
				}
				expect {
					post :create, params: params
				}.to change(Email, :count).by(1)
				
				status = JSON.parse(response.body)["status"]
				email = JSON.parse(response.body)["email"]
				template = JSON.parse(response.body)["template"]

				expect(response).to have_http_status(201)
				expect(status).to eq(201)
				expect(email["status"]).to eq("pending")
				expect(template["name"]).to eq("RESERVATION_CONFIRMED")
			end
		end

		context "with invalid 'to' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: template.name,
					},
					email: {
						to: "invalid email",
						from: email.from,
					},
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
				
				status = JSON.parse(response.body)["status"]
				template = JSON.parse(response.body)["template"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(400)
				expect(status).to eq(400)
				expect(template["name"]).to eq("RESERVATION_CONFIRMED")
				expect(errors).to_not be_nil
			end
		end

		context "with invalid 'from' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: template.name,
					},
					email: {
						to: email.to,
						from: "invalid email",
					},
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
				
				status = JSON.parse(response.body)["status"]
				template = JSON.parse(response.body)["template"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(400)
				expect(status).to eq(400)
				expect(template["name"]).to eq("RESERVATION_CONFIRMED")
				expect(errors).to_not be_nil
			end
		end

		context "with invalid template 'name' attribute" do
			it "does not save new email" do
				params = {
					template: {
						name: "invalid template name",
					},
					email: {
						to: email.to,
						from: email.from,
					},
				}
				expect {
					post :create, params: params
				}.to_not change(Email, :count)
								
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(400)
				expect(status).to eq(400)
				expect(errors).to_not be_nil
			end
		end
	end
end
