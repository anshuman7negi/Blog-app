require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET #index' do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 5) }

  it 'returns a success response' do
    get "/user/#{user.id}/posts"
    expect(response).to have_http_status(:success)
  end

  it 'renders the index template' do
    get "/user/#{user.id}/posts"
    expect(response).to render_template(:index)
  end
end

describe 'GET #show' do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 5) }
  let(:post) { Post.create(title: 'Sample Title', author: user, text: 'This is my first post', comments_counter: 0, likes_counter: 0) }

  it 'returns a success response' do
    get "/user/#{user.id}/posts/#{post.id}"
    expect(response).to have_http_status(:success)
  end

  it 'renders the show template' do
    get "/user/#{user.id}/posts/#{post.id}"
    expect(response).to render_template(:show)
  end
end
end
