class Template < ApplicationRecord
	# validations
	validates :name, presence: true
	validates :subject, presence: true
	validates :html, presence: true

	# relationships
	has_many :emails
end
