
FactoryBot.define do
	factory :user_query do
		query{ "how to" }
		ip_address{ "1" }
		# Add other attributes here
	end
end