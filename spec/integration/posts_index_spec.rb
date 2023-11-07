require 'rails_helper'

RSpec.describe 'User Posts Page', type: :system do
  before do
    User.destroy_all
    Post.destroy_all

    @user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', posts_counter: 0, photo: 'https://example.com/user1.jpg')
    @post1 = Post.create(author: @user, title: 'Post1', text: 'This is the first post.', comments_counter: 0,
                         likes_counter: 0)
  end

  scenario 'displays user profile information and no posts' do
    visit user_posts_path(@user)

    expect(page).to have_selector("img[src*='https://example.com/user1.jpg']")
    expect(page).to have_content('Tom')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_button('Create new post')
    expect(page).to have_content('There are no comments for this post.')
    expect(page).to have_content("Comments: #{@post1.comments_counter}")
    expect(page).to have_content("Likes: #{@post1.likes_counter}")
  end

  scenario 'displays user posts with comments and likes' do
    post = Post.create(author: @user, title: 'Post2', text: 'This is the second post.', comments_counter: 2,
                       likes_counter: 5)

    comment1 = Comment.create(post:, user: @user, text: 'Great post!')
    comment2 = Comment.create(post:, user: @user, text: 'I love it!')

    visit user_posts_path(@user)

    expect(page).to have_content('This is the first post.')
    expect(page).to have_content("Comments: #{post.comments_counter}")
    expect(page).to have_content("Likes: #{post.likes_counter}")

    expect(page).to have_content('Tom: Great post!')
    expect(page).to have_content('Tom: I love it!')
  end

  scenario 'pagination button redirects to correct post' do
    visit user_posts_path(@user)

    click_button('Pagination')
    sleep(2)
    expect(current_path).to eq(user_post_path(@user, @post1))
  end

  scenario 'click the user posts' do
    last_post = Post.create(author: @user, title: 'last post', text: 'This is the last post.', comments_counter: 2,
                            likes_counter: 5)
    visit user_path(@user)
    click_link 'Post #1'
    sleep(2)
    expect(current_path).to eq(user_post_path(@user, last_post))
  end

  scenario 'click "Create new post" button' do
    visit user_posts_path(@user)

    click_button('Create new post')
    sleep(2)

    expect(current_path).to eq(new_user_post_path(@user))
  end
end
