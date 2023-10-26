class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :increment_no_of_posts

  def recent_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_no_of_posts
    author.increment!(:posts_counter)
  end
end
