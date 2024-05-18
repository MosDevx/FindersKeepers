json.extract! article, :id, :title, :category, :author, :published_date, :created_at, :updated_at
json.url article_url(article, format: :json)
