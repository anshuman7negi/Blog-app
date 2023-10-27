class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_no_of_comments
  after_destroy :decrement_post_comments_counter

  private

  def increment_no_of_comments
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter)
  end
end
