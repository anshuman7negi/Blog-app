class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_no_of_likes
  after_destroy :decrement_likes_counter

  private

  def increment_no_of_likes
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end
end
