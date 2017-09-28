namespace :emails do
	desc "send emails via sendgrid api"
	task send: :environment do
		log = ActiveSupport::Logger.new('log/emails_send.log')
		start_time = Time.now
		log.info "emails:send task started at #{start_time}"

		emails = Email.pending
		log.info "#{emails.count} pending #{'email'.pluralize(emails.count)} to send..."
		emails.each do |email|
			log.info "sending email #{email.id}"
			email = SendgridService.send_email(email)
			log.info "email #{email.id} #{email.status}"
		end

		emails = Email.failed
		log.info "#{emails.count} failed #{'email'.pluralize(emails.count)} to send..."
		emails.each do |email|
			log.info "sending email #{email.id}"
			email = SendgridService.send_email(email)
			log.info "email #{email.id} #{email.status}"
		end

		end_time = Time.now
		duration = (start_time - end_time) / 1.minute
		log.info "emails:send task finished at #{end_time} and lasted #{duration} minutes"
		log.close
	end
end
