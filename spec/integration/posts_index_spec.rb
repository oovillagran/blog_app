require 'rails_helper'

RSpec.feature 'PostsIndex', type: :feature do
  before do
    @user = User.create(name: 'John', photo: 'user1.jpg', bio: 'I am John')
    @post1 = @user.posts.create(title: 'Post 1', text: 'Post 1 Text')
    @post2 = @user.posts.create(title: 'Post 2', text: 'Post 2 Text')
    @post3 = @user.posts.create(title: 'Post 3', text: 'Post 3 Text')
    @comment1 = @post1.comments.create(text: 'Hi friend!', author: @user)
    @comment2 = @post2.comments.create(text: 'Nice', author: @user)
    @comment3 = @post3.comments.create(text: 'Awesome', author: @user)
    @like1 = @post1.likes.create(author: @user)
    @like2 = @post2.likes.create(author: @user)
    @like3 = @post3.likes.create(author: @user)

    visit user_posts_path(user_id: @user.id)
  end

  scenario "shows the user's profile picture" do
    expect(page).to have_selector("img[src$='#{@user.photo}']")
  end

  scenario "shows the user's name" do
    expect(page).to have_content(@user.name)
  end

  scenario "shows the number of posts" do
    expect(page).to have_content("Number of Posts: 3")
  end

  scenario "when click on a post, it redirects to the post page" do
    post = Post.find_by(title: 'Post 1')
    click_link post.title

    expect(current_path).to eq(user_post_path(user_id: @user.id, id: post.id))
  end

  scenario "shows the user's posts title and text" do
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'shows comments on posts#index page' do
    expect(page).to have_content('Hi friend!')
  end

  scenario 'Likes on posts#index page' do
    expect(page).to have_content('Likes: 1')
  end

  scenario 'Comments counter on posts#index page' do
    expect(page).to have_content('Comments: 1')
  end
end
