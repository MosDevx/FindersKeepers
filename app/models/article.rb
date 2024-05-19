# app/models/article.rb
class Article < ApplicationRecord
  include PgSearch::Model
  validates :title, presence: true
  validates :category, presence: true

  pg_search_scope :search_by_title_and_category, 
                  against: [:title, :category],
                  using: {
                    tsearch: { prefix: true, any_word: true},
										trigram: { threshold: 0.2}
                  }
end
