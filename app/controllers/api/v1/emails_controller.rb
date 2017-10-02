module Api
	module V1
		class EmailsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def create
				if template = Template.find_by_name(params[:template][:name])
					email = Email.new(email_params)
					email.template_id = template.id
					if email.save
						render status: 201, json: {
							status: 201,
							email: email,
							template: template,
						}
					else
						render status: 400, json: { 
							status: 400,
							errors: email.errors.full_messages,
							template: template,
						}
					end
				else
					render status: 400, json: { 
						status: 400,
						errors: ["template does not exist"],
					}
				end
			end
			
			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						ApiKey.exists?(access_token: token)
					end
				end

				def email_params
					params.require(:email).permit(:to, :from, :template_id, :subs)
				end
		end
	end
end
