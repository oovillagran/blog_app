class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 2..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :text, presence: true

  before_validation :set_default_counters

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  after_create :update_user_posts_counter
  after_create :initialize_counters

  def five_most_recent_comments
    comments.includes(:post, :author).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def initialize_counters
    update(comments_counter: 0, likes_counter: 0)
  end

  def set_default_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
