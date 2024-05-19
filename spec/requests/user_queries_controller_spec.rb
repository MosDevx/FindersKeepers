require 'rails_helper'

RSpec.describe UserQueriesController, type: :request do
  describe "GET /user_queries" do
    before do
      # Ensure there are records in the database for testing purposes
      UserQuery.create(query: "test_query1", ip_address: 1)
      UserQuery.create(query: "test_query2", ip_address: 2)
      UserCount.create(ip_address: 1)
      UserCount.create(ip_address: 2)
    end

    it "returns a successful response" do
      get "/user_queries"
      expect(response).to be_successful
    end

    it "assigns @total_queries" do
      get "/user_queries"
      expect(assigns(:total_queries)).to eq(UserQuery.count)
    end

    it "assigns @unique_visitors" do
      get "/user_queries"
      expect(assigns(:unique_visitors)).to eq(UserQuery.distinct.count(:ip_address))
    end

    it "assigns @unique_queries" do
      get "/user_queries"
      expect(assigns(:unique_queries)).to eq(UserQuery.select(:query).distinct.count)
    end

    it "assigns @most_common_queries" do
      get "/user_queries"
      expected_common_queries = UserQuery.group(:query).count.sort_by { |_k, v| v }.reverse.first(10)
      expect(assigns(:most_common_queries)).to eq(expected_common_queries)
    end

    it "rescues and assigns an empty array to @most_common_queries when an error occurs" do
      allow(UserQuery).to receive(:group).and_raise(StandardError.new("Error"))
      get "/user_queries"
      expect(assigns(:most_common_queries)).to eq([])
    end
  end
end
