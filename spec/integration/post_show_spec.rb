require 'rails_helper'

RSpec.describe 'Post and Comments Page', type: :system do
  before do
    User.destroy_all
    Post.destroy_all

    @user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', posts_counter: 0, photo: 'https://example.com/user1.jpg')
    @post = Post.create(author: @user, title: 'Post1', text: 'This is the first post.', comments_counter: 0, likes_counter: 0)
  end

  scenario 'displays post information and no comments' do
    visit user_post_path(@user, @post)

    expect(page).to have_content("Post #1 by Tom")
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    expect(page).to have_content("Likes: #{@post.likes_counter}")
    expect(page).to have_content('This is the first post.')
    expect(page).to have_button('Like post')
    expect(page).to have_button('Create new comment')
    expect(page).to have_content('There are no comments for this post.')
  end

  scenario 'displays post information with comments and likes' do
    comment1 = Comment.create(post: @post, user: @user, text: 'Great post!')
    comment2 = Comment.create(post: @post, user: @user, text: 'I love it!')

    visit user_post_path(@user, @post)

    expect(page).to have_content("Post #1 by Tom")
    expect(page).to have_content('Comments: 2, Likes: 0')
    expect(page).to have_content('This is the first post.')
    expect(page).to have_button('Like post')
    expect(page).to have_button('Create new comment')

    expect(page).to have_content('Tom: Great post!')
    expect(page).to have_content('Tom: I love it!')
  end

  scenario 'like post' do
    visit user_post_path(@user, @post)
    initial_like_count = @post.likes_counter

    click_button('Like post')
    sleep(3)
    visit user_post_path(@user, @post)
    updated_like_count = @post.reload.likes_counter 
    expect(updated_like_count).to eq(initial_like_count + 1)

  end

  scenario 'click "Create new comment" button' do
    visit user_post_path(@user, @post)

    click_button('Create new comment')
    sleep(2)

    expect(current_path).to eq(new_user_post_comment_path(post_id: @post.id, user_id: @post.author_id))
  end

end
