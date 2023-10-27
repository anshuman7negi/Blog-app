require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "increments the post's comments_counter after create" do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user, text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    Comment.create(user:, post:)
    expect(post.reload.comments_counter).to eq(1)
  end

  it "decrements the post's comments_counter after destroy" do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user, text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    comment = Comment.create(user:, post:)
    comment.destroy
    expect(post.reload.comments_counter).to eq(0)
  end
end
