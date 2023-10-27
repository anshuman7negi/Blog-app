require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter >= 0' do
    user = User.new(name: 'Roy Batty', posts_counter: 5)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, posts_counter: 5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a non-integer posts_counter' do
    user = User.new(name: 'Roy Batty', posts_counter: 5.5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'Roy Batty', posts_counter: -1)
    expect(user).not_to be_valid
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Roy Batty', posts_counter: 4)

      post0 = user.posts.create(title: 'Post 0', text: 'hey', created_at: 3.days.ago, comments_counter: 0,
                                likes_counter: 0)
      post1 = user.posts.create(title: 'Post 1', text: 'hey', created_at: 2.days.ago, comments_counter: 0,
                                likes_counter: 0)
      post2 = user.posts.create(title: 'Post 2', text: 'hey', created_at: 1.day.ago, comments_counter: 0,
                                likes_counter: 0)
      post3 = user.posts.create(title: 'Post 3', text: 'hey', created_at: Time.current, comments_counter: 0,
                                likes_counter: 0)

      recent_posts = [post3, post2, post1]

      expect(user.recent_posts).to eq(recent_posts)
    end
  end
end
