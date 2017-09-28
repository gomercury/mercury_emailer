templates = [
	{
		name: "RESERVATION_CONFIRMED",
		sendgrid_id: "3b7ac025-f0d5-4540-baba-30e2b4c8a9e8",
	},
	{
		name: "RESERVATION_MODIFIED",
		sendgrid_id: "0a473190-6d12-40cf-9b3a-ddce0f56a482",
	},
	{
		name: "RESERVATION_CANCELLED",
		sendgrid_id: "27853a42-54de-4538-9a9e-b05c010f9483",
	},
]

templates.each do |params|
	unless Template.find_by_name(params[:name])
		template = Template.create(
			name: params[:name],
			sendgrid_id: params[:sendgrid_id],
		)
		puts "template created: #{template.name}"
	end
end
