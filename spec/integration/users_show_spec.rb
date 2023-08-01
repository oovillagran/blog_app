require 'rails_helper'

RSpec.feature 'UsersShow', type: :feature do
  before do
    @user = User.create(name: 'John', photo: 'user1.jpg', bio: 'I am John')
    @user.update(posts_counter: 5)

    
    first_post =  Post.create(title: 'First Post', text: 'First Post Text', author: @user)
    second_post =  Post.create(title: 'Second Post', text: 'Second Post Text', author: @user)
    third_post =  Post.create(title: 'Third Post', text: 'Third Post Text', author: @user)
    fourth_post =  Post.create(title: 'Fourth Post', text: 'Fourth Post Text', author: @user)
    fifth_post =  Post.create(title: 'Fifth Post', text: 'Fifth Post Text', author: @user)

    visit user_path(@user)
  end

  scenario "shows the user's profile picture" do
    expect(page).to have_selector("img[src$='#{@user.photo}']")
  end

  scenario "shows the user's name" do
    expect(page).to have_content(@user.name)
  end

  scenario "shows the number of posts" do
    expect(page).to have_content("Number of Posts: #{@user.posts_counter}")
  end

  scenario 'shows the user bio' do
    expect(page).to have_content(@user.bio)
  end

  scenario "shows the user's three most recent posts" do
    recent_posts = @user.returns_the_three_most_recent_posts

    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario "when click on a post, it redirects to the post page" do
    post = Post.find_by(title: 'Third Post')
    click_link post.title

    expect(current_path).to eq(user_post_path(user_id: @user.id, id: post.id))
  end
end
