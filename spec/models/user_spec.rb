require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be presented' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'if a post is created the post_counter should be a positive number' do
    post = Post.new(author: subject, title: 'Hello', text: 'Working with Rspec.')
    post.save

    expect(subject.posts_counter).to be >= 0
  end
end
