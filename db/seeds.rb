# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Custom method to generate random article titles with more variety and ensure they are in English
def generate_article_title
  case rand(1..8)
  when 1
    "How to #{Faker::Verb.base.capitalize} #{Faker::Book.genre} Books in #{rand(3..10)} Easy Steps"
  when 2
    "#{rand(5..15)} Tips for Enjoying #{Faker::Book.title}"
  when 3
    "The Ultimate Guide to #{Faker::Hobby.activity.capitalize}"
  when 4
    "Exploring the Benefits of Watching #{Faker::Movie.title}"
  when 5
    "Top #{rand(3..10)} Strategies for Getting into #{Faker::Hobby.activity.capitalize}"
  when 6
    "Why Reading #{Faker::Book.title} Can Improve Your Life"
  when 7
    "The #{rand(3..10)} Best Ways to Enjoy #{Faker::Movie.title}"
  when 8
    "How #{Faker::Book.genre} Books Can Enhance Your #{Faker::Job.field.capitalize} Skills"
  when 9
    "Discovering the Wonders of Space: #{Faker::Space.galaxy} Edition"
  when 10
    "Top #{rand(3..10)} Superhero Movies to Watch This Year"
  when 11
    "How #{Faker::Sports::Football.team} Became Champions"
  when 12
    "Exploring the World of Comics: #{Faker::DcComics.title}"
  end
end

# Custom method to generate random article categories
def generate_article_category
  categories = [
    "Books",
    "Movies",
    "Hobbies",
    "Jobs",
    "Space",
    "Superheroes",
    "Sports",
    "Comics"
  ]
  categories.sample
end

# Number of articles to generate
num_articles = 50

# Generate and save articles
num_articles.times do
  title = generate_article_title
  category = generate_article_category
  author = Faker::Book.author
  published_date = Faker::Date.backward(days: 365 * 5).strftime('%Y-%m-%d')

  Article.create(
    title: title,
    category: category,
    author: author,
    published_date: published_date
  )
end
