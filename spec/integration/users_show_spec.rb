require 'rails_helper'

RSpec.feature 'UsersShow', type: :feature do
  before do
    @user = User.create(name: 'John', photo: 'user1.jpg', bio: 'I am John')
    visit user_path(@user)
  end

  scenario "shows the user's profile picture" do
    expect(page).to have_selector("img[src$='#{@user.photo}']")
  end

  scenario "shows the user's name" do
    expect(page).to have_content(@user.name)
  end

  scenario "shows the user's number of posts" do
    expect(page).to have_content("Number of Posts: #{@user.posts_counter}")
  end

  scenario 'shows the user bio' do
    expect(page).to have_content(@user.bio)
  end
end
