class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :update_post_likes_counter

  validates :author_id, uniqueness: { scope: :post_id, message: "You have already liked this post." }

  private

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
