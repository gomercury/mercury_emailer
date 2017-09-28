class Template < ApplicationRecord
	# validations
	validates :name, presence: true
	validates :sendgrid_id, presence: true

	# relationships
	has_many :emails
end
