require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /index" do
    it "renders the index template" do
      get articles_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      article = Article.create(title: "Test Article", category: "Books")
      get article_path(article)
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH /update" do
    it "updates an existing article" do
      article = Article.create(title: "Test Article", category: "Books")
      patch article_path(article), params: { article: { title: "Updated Article" } }
      expect(article.reload.title).to eq("Updated Article")
    end
  end

end
require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /index" do
    it "renders the index template" do
      get articles_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "renders the show template" do
      article = Article.create(title: "Test Article", category: "Books")
      get article_path(article)
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH /update" do
    it "updates an existing article" do
      article = Article.create(title: "Test Article", category: "Books")
      patch article_path(article), params: { article: { title: "Updated Article" } }
      expect(article.reload.title).to eq("Updated Article")
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      get new_article_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do
    it "creates a new article" do
      expect {
        post articles_path, params: { article: { title: "New Article", category: "Books" } }
      }.to change(Article, :count).by(1)
    end
  end

  describe "GET /edit" do
    it "renders the edit template" do
      article = Article.create(title: "Test Article", category: "Books")
      get edit_article_path(article)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT /update" do
    it "updates an existing article" do
      article = Article.create(title: "Test Article", category: "Books")
      put article_path(article), params: { article: { title: "Updated Article" } }
      expect(article.reload.title).to eq("Updated Article")
    end
  end

  describe "DELETE /destroy" do
    it "destroys an existing article" do
      article = Article.create(title: "Test Article", category: "Books")
      expect {
        delete article_path(article)
      }.to change(Article, :count).by(-1)
    end
  end
end