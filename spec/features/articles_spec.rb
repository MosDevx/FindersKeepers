require 'rails_helper'

RSpec.feature "Articles", type: :feature do



  scenario "User can create a new article" do
    # Add your test code here
    visit new_article_path
    fill_in "Title", with: "New Article"
    fill_in "Category", with: "Movies"
    click_button "Create Article"
    expect(page).to have_content("Article was successfully created.")
  end


end
