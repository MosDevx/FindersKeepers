# spec/features/user_queries_spec.rb
require 'rails_helper'

RSpec.describe "UserQueries", type: :feature do
  before do
    create(:article, title: "The quick brown fox")
    create(:article, title: "The lazy dog")
  end

  it "User can perform a search" do
    visit root_path
    fill_in "search-box", with: "the"
    click_button "Search"
    expect(page).to have_content("The quick brown fox")
    expect(page).to have_content("The lazy dog")
  end
end
