require 'rails_helper'
RSpec.describe 'Users Page', type: :system do
  before do
    User.destroy_all
    Post.destroy_all
    
    @first_user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', posts_counter: 0, photo: 'https://example.com/user1.jpg')
    @second_user = User.create(name: 'som', bio: 'Teacher from Mexico.', posts_counter: 4, photo: 'https://example.com/user1.jpg')
    @third_user = User.create(name: 'pom', bio: 'Teacher from Mexico.', posts_counter: 5, photo: 'https://example.com/user1.jpg')
    
    @post1 = Post.create(author: @first_user, title: 'Post1', text: 'This is the first post.', comments_counter: 0, likes_counter: 0)
  end
  scenario 'display users when there are users' do
    visit root_path
    expect(page).to have_selector('.user-container', count: 3)
    expect(page).to have_content('Tom')
    expect(page).to have_content('pom')
  end
  scenario 'click user profile link' do
    visit root_path
    click_link('Tom')
    sleep(2)
    expect(current_path).to eq(user_path(@first_user))
  end
  scenario 'profile picture for each user' do
    visit root_path
    expect(page).to have_selector('.profile-pic', count: 3)
  end
  scenario 'number of posts each user has written' do
    visit root_path
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 5')
    expect(page).to have_content('Number of posts: 4')
  end
end