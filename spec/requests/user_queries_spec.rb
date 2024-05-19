require 'rails_helper'

RSpec.describe "UserQueries", type: :request do
  describe "GET /user_queries" do
    it "works! (now write some real specs)" do
      get user_queries_path
      expect(response).to have_http_status(200)
    end
  end
end
