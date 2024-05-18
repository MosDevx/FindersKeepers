# app/models/article.rb
class Article < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title_and_author, 
                  against: [:title, :author],
                  using: {
                    tsearch: { prefix: true }
                  }
end
