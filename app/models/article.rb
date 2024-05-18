# app/models/article.rb
class Article < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title_and_category, 
                  against: [:title, :category],
                  using: {
                    tsearch: { prefix: true },
										trigram: { threshold: 0.3 }
                  }
end
