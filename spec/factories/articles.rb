# spec/factories/articles.rb

FactoryBot.define do
	factory :article do
		title { "Sample Article" }
		category { "Sample Category" }
		# Add other attributes here
	end
end