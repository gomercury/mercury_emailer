class SendgridService
	def self.send_email(email)
		response = ApplicationMailer.send_email(email).deliver
		if response.errors.any?
			email.status = "failed"
			email.error = response.errors.to_s
		else
			email.status = "succeeded"
		end
		email.save
		return email
	end
end
