# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Sendgrid settings to send emails
ActionMailer::Base.smtp_settings = {
  user_name: Rails.application.secrets.username,
  password: Rails.application.secrets.password,
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true,
}
