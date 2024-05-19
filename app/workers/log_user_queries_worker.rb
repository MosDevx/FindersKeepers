class LogUserQueriesWorker
  include Sidekiq::Worker

  STOP_WORDS = %w(
    a about above after again against all am an and any are aren't as at be because been before being below between both but by can't cannot could couldn't did didn't do does doesn't doing don't down during each few for from further had hadn't has hasn't have haven't having he he'd he'll he's her here here's hers herself him himself his how how's i i'd i'll i'm i've if in into is isn't it it's its itself let's me more most mustn't my myself no nor not of off on once only or other ought our ours ourselves out over own same shan't she she'd she'll she's should shouldn't so some such than that that's the their theirs them themselves then there there's these they they'd they'll they're they've this those through to too under until up very was wasn't we we'd we'll we're we've were weren't what what's when when's where where's which while who who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours yourself yourselves
  ).freeze

  def perform
    queries = Rails.cache.read('user_queries') || []
    queries.each do |query|
      if stop_word_query?(query[:query])
        UserCount.create!(ip_address: query[:ip_address]) unless UserCount.exists?(ip_address: query[:ip_address])
      else
        UserQuery.create!(query: query[:query], ip_address: query[:ip_address])
      end
    end
    Rails.cache.delete('user_queries')
  end

  private

  def stop_word_query?(query)
    query_words = query.downcase.split
    query_words.all? { |word| STOP_WORDS.include?(word) }
  end
end