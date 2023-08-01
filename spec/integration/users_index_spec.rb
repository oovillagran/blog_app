require 'rails_helper'

RSpec.feature 'UsersIndex', type: :feature do
  before do
    @users = [
      User.create(name: 'John', photo: 'user1.jpg', bio: 'I am John'),
      User.create(name: 'Jane', photo: 'user2.jpg', bio: 'I am Jane'),
      User.create(name: 'Jack', photo: 'user3.jpg', bio: 'I am Jack')
    ]

    visit users_path
  end

  scenario 'index shows the username of all users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'index shows the photo of all users' do
    @users.each do |user|
      expect(page).to have_selector("img[src$='#{user.photo}']")
    end
  end

  scenario 'index shows the number of posts of each user' do
    @users.each do |user|
      expect(page).to have_content("Number of Posts: #{user.posts_counter}")
    end
  end

  scenario 'when click on a user, it redirects to the user profile' do
    click_link @users[1].name

    expect(page).to have_current_path(user_path(@users[1]))
  end
end
