class Email < ApplicationRecord
	# validations
	validates_email_format_of :to
	validates_email_format_of :from
	validates :status, presence: true
	validates :template_id, presence: true, numericality: true

	# relationships
	belongs_to :template

	# scopes
	scope :pending, -> { where(status: "pending") }
	scope :failed, -> { where(status: "failed") }
end
