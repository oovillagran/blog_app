# require 'rails_helper'

# RSpec.describe Post, type: :model do
#   subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

#   it 'title should be presented' do
#     post = Post.new(author: subject, title: 'Hello', text: 'Working with Rspec.')
#     post.save

#     post.title = nil
#     expect(post).to_not be_valid
#   end

#   it 'title should be no longer than 250 characters' do
#     post = Post.new(author: subject, title: 'Hello', text: 'Working with Rspec.')
#     post.save

#     post.title = 'a' * 251
#     expect(post).to_not be_valid
#   end

#   it 'should set comments_counter and likes_counter to zero on create' do
#     post = Post.new(author: subject, title: 'Hello', text: 'Working with Rspec.')
#     post.save

#     expect(post.comments_counter).to eq(0)
#     expect(post.likes_counter).to eq(0)
#   end

#   # it 'if exist comments, count of comments should be a positive number' do
#   #   post = Post.new(author: subject, title: 'Hello', text: 'Working with Rspec.')
#   #   post.save

#   #   comment = Comment.new(post: post, text: 'Hi Tom!', author: subject)
#   #   comment.save!

#   #   post.reload

#   #   expect(post.comments_counter).to be >= 0
#   # end
# end

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Jose', posts_counter: 0) }

  subject { described_class.create(author:, title: 'title', comments_counter: 0, likes_counter: 0) }

  let(:first_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:second_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:third_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:forth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:fifth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:sixth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }

  let(:first_like) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:second_like) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }

  context '#title' do
    it 'should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should not exceed 250 characters' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end
  end

  context '#comments_count' do
    it 'should NOT be less than zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be an greater than or equal to zero' do
      subject.comments_counter = 0
      expect(subject).to be_valid

      subject.comments_counter = 1
      expect(subject).to be_valid
    end

    it 'should be an interger' do
      subject.comments_counter = 0.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of comments created' do
      first_comment
      second_comment
      third_comment
      expect(subject.comments_counter).to eq(Comment.all.size)
    end
  end

  context '#likes_count' do
    it 'should NOT be less than zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be an greater than or equal to zero' do
      subject.likes_counter = 0
      expect(subject).to be_valid

      subject.likes_counter = 1
      expect(subject).to be_valid
    end

    it 'should be an interger' do
      subject.likes_counter = 0.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of likes created' do
      first_like
      second_like
      expect(subject.likes_counter).to eq(Like.all.size)
    end
  end

  context '#methods' do
    it 'recent_comments returns the five most recent comments' do
      first_comment
      second_comment
      third_comment
      forth_comment
      fifth_comment
      sixth_comment
      recent_comments_array = [sixth_comment, fifth_comment, forth_comment, third_comment, second_comment]
      expect(subject.five_most_recent_comments).to eq(recent_comments_array)
    end
  end
end