require 'rails_helper'

RSpec.describe UserQuery, type: :model do
  describe 'validations' do
    it 'validates presence of query' do
      user_query = UserQuery.new(ip_address: '127.0.0.1')
      expect(user_query).not_to be_valid
      expect(user_query.errors[:query]).to include("can't be blank")
    end

    it 'validates presence of ip_address' do
      user_query = UserQuery.new(query: 'example query')
      expect(user_query).not_to be_valid
      expect(user_query.errors[:ip_address]).to include("can't be blank")
    end
  end
end
