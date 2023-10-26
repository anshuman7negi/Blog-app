class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_no_of_likes

  private

  def increment_no_of_likes
    post.increment!(:likes_counter)
  end
end
