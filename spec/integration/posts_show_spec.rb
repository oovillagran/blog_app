require 'rails_helper'

RSpec.feature 'PostsShow', type: :feature do
  before do
    @user = User.create(name: 'John', photo: 'user1.jpg', bio: 'I am John')
    @user1 = User.create(name: 'Jane', photo: 'user2.jpg', bio: 'I am Jane')
    @user2 = User.create(name: 'Jack', photo: 'user3.jpg', bio: 'I am Jack')
    @post1 = @user.posts.create(title: 'Post 1', text: 'Post 1 Text')
    @post2 = @user.posts.create(title: 'Post 2', text: 'Post 2 Text')
    @post3 = @user.posts.create(title: 'Post 3', text: 'Post 3 Text')
    @comment1 = @post1.comments.create(text: 'Hi friend!', author: @user)
    @comment2 = @post1.comments.create(text: 'Nice', author: @user1)
    @comment3 = @post1.comments.create(text: 'Awesome', author: @user2)
    @like1 = @post1.likes.create(author: @user)
    @like2 = @post1.likes.create(author: @user1)
    @like3 = @post1.likes.create(author: @user2)

    visit user_posts_path(user_id: @user.id, post_id: @post1.id)
  end

  scenario "shows the post id" do
    expect(page).to have_content(@post1.id)
  end

  scenario "shows the post text" do
    expect(page).to have_content(@post1.text)
  end

  scenario "shows the post's author" do
    expect(page).to have_content(@post1.author.name)
  end

  scenario "shows the post's comments" do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
    expect(page).to have_content(@comment3.text)
  end

  scenario "shows the post's likes" do
    expect(page).to have_content('Likes: 3')
  end

  scenario "shows the post's comments counter" do
    expect(page).to have_content('Comments: 3')
  end

  scenario 'shows the comment\'s author' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
    expect(page).to have_content(@comment3.author.name)
  end
end