require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  before do
    User.destroy_all
    Post.destroy_all

    @first_user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', posts_counter: 0, photo: 'https://example.com/user1.jpg')

    @post1 = Post.create(author: @first_user, title: 'Post1', text: 'This is the first post.', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author: @first_user, title: 'Post2', text: 'This is the second post.', comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(author: @first_user, title: 'Post3', text: 'This is the third post.', comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(author: @first_user, title: 'Post4', text: 'This is the fourth post.', comments_counter: 0,
                         likes_counter: 0)
  end

  scenario 'displays the user profile information' do
    visit user_path(@first_user)
    expect(page).to have_selector("img[src*='https://example.com/user1.jpg']")
    expect(page).to have_content('Tom')
    expect(page).to have_content('Number of posts: 4')
    expect(page).to have_content('Teacher from Mexico')


    [@post4, @post3, @post2].each do |post|
      expect(page).to have_content(post.text)
    end

    click_link 'See all posts'
    sleep(2)
    expect(current_path).to eq(user_posts_path(@first_user))
  end

  scenario 'click the user posts' do
    visit user_path(@first_user)
    click_link 'Post #1'
    sleep(2)
    expect(current_path).to eq(user_post_path(@first_user, @post4))
  end

  scenario 'handles no recent posts' do
    @second_user = User.create(name: 'Alice', bio: 'Developer from USA.', posts_counter: 0, photo: 'https://example.com/user2.jpg')
    visit user_path(@second_user)

    expect(page).to have_content('There are no posts by this user.')
    expect(page).not_to have_button('See all posts')
  end
end
