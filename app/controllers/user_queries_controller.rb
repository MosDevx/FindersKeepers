# app/controllers/user_queries_controller.rb
class UserQueriesController < ApplicationController
  def index
    @total_queries = UserQuery.count
    @unique_visitors = UserCount.distinct.count(:user_id)
    @unique_queries = UserQuery.select(:query).distinct.count
    @most_common_queries = UserQuery.group(:query).count.sort_by { |_k, v| v }.reverse.first(10)
  rescue => e
    @most_common_queries = []
    Rails.logger.error "Failed to retrieve queries: #{e.message}"
  end
end
