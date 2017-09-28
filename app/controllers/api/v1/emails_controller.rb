module Api
	module V1
		class EmailsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def create
				if template = Template.find_by_name(params[:template][:name])
					email = Email.new(
						template_id: template.id,
						to: params[:to],
						from: params[:from],
						subs: params[:subs],
					)
					if email.save
						render status: :created, json: email
					else
						render status: :bad_request, json: { errors: email.errors.full_messages }
					end
				else
					render status: :bad_request, json: { errors: "template does not exist" }
				end
			end
			
			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						ApiKey.exists?(access_token: token)
					end
				end
		end
	end
end
