class UserQueriesController < ApplicationController
  def index
    # Add your logic here
		@total_queries = UserQuery.count
    @unique_visitors = UserCount.count
    @unique_queries = UserQuery.select(:query).distinct.count
		begin
			@most_common_queries = UserQuery.group(:query).count.sort_by { |_k, v| v }.reverse.first(10)
		rescue => e
			Rails.logger.error "Error setting @most_common_queries: #{e.message}"
			@most_common_queries = []
		end
  end
end