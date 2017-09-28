class ApplicationMailer < ActionMailer::Base
  def send_email(email)
  	subs = {}
		if email.subs
			email.subs.each do |key, value|
				subs["%" + key + "%"] = value
			end
		end

		headers "X-SMTPAPI" => {
			"sub": subs,
			"filters": {
				"templates": {
					"settings": {
						"enable": 1,
						"template_id": email.template_id,
					}
				}
			}
		}.to_json

		mail(
			to: email.to, 
			from: email.from,
		)
  end
end

