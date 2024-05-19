# app/workers/log_user_queries_worker.rb
class LogUserQueriesWorker
  include Sidekiq::Worker

  def perform
    queries = Rails.cache.read('user_queries') || []
    queries.each do |query|
      # Assuming you have a UserQuery model to store queries
      UserQuery.create!(query: query[:query], ip_address: query[:ip_address])
    end
    Rails.cache.delete('user_queries')
  end
end
