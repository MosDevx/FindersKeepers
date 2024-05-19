
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "is valid with a title and category" do
      article = Article.new(title: "Sample Article", category: "Sample Category")
      expect(article).to be_valid
    end

    it "is invalid without a title" do
      article = Article.new(category: "Sample Category")
      expect(article).to_not be_valid
    end

    it "is invalid without a category" do
      article = Article.new(title: "Sample Article")
      expect(article).to_not be_valid
    end
  end

  describe "search" do
    it "returns articles with matching title and category" do
      Article.create(title: "Sample Article", category: "Sample Category")
      Article.create(title: "Another Article", category: "Sample Category")
      Article.create(title: "Sample Article", category: "Another Category")

      results = Article.search_by_title_and_category("Sample")
      expect(results.count).to eq(3)
      expect(results.pluck(:title)).to include("Sample Article", "Another Article")
    end

    it "returns empty results for non-matching title and category" do
      Article.create(title: "Sample Article", category: "Sample Category")

      results = Article.search_by_title_and_category("Non-Matching")
      expect(results.count).to eq(0)
    end
  end
end
