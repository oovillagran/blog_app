class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  after_create :update_user_posts_counter

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end
end
