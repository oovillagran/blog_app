require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Jules', posts_counter: 0) }

  subject { Post.create(author:, title: 'Hello', text: 'Working with Rspec.', comments_counter: 0, likes_counter: 0) }

  let(:first_comment) { Comment.create(post: subject, author:, text: 'Hi Jules!') }
  let(:second_comment) { Comment.create(post: subject, author:, text: 'Nice') }
  let(:third_comment) { Comment.create(post: subject, author:, text: 'Congratulations') }
  let(:fourth_comment) { Comment.create(post: subject, author:, text: 'Excellent') }
  let(:fifth_comment) { Comment.create(post: subject, author:, text: 'Good Job') }
  let(:sixth_comment) { Comment.create(post: subject, author:, text: 'Like it') }

  let(:first_like) { Like.create(post: subject, author:) }
  let(:second_like) { Like.create(post: subject, author:) }

  context '#Post' do
    it 'title should be presented' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be no longer than 250 characters' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end
  end

  context '#comments_counter' do
    it 'should nOT be less than zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be greater than or equal to zero' do
      subject.comments_counter = 0
      expect(subject).to be_valid

      subject.comments_counter = 1
      expect(subject).to be_valid
    end

    it 'should be an integer' do
      subject.comments_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of comments created' do
      first_comment
      second_comment
      third_comment
      expect(subject.comments_counter).to eq(3)
    end
  end

  context '#likes_counter' do
    it 'should not be less than zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be greater than or equal to zero' do
      subject.likes_counter = 0
      expect(subject).to be_valid

      subject.likes_counter = 1
      expect(subject).to be_valid
    end

    it 'should be an integer number' do
      subject.likes_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of likes created' do
      first_like
      second_like
      expect(subject.likes_counter).to eq(Like.all.size)
    end
  end

  context 'Five most recent comments' do
    it 'returns the five most recent comments' do
      first_comment
      second_comment
      third_comment
      fourth_comment
      fifth_comment
      sixth_comment
      recent_comments_array = [sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment]
      expect(subject.five_most_recent_comments).to eq(recent_comments_array)
    end
  end
end
