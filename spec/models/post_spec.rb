require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 5) }
  subject do
    described_class.new(author: first_user, title: 'Hello world', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
  end

  before { subject.save }

  # Validation tests
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of comments_counter' do
      subject.comments_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of likes_counter' do
      subject.likes_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates that comments counter is a positive integer' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'validates that likes counter is a positive integer' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid with a title > 250 characters' do
      subject.title = 'A' * 251
      expect(subject).not_to be_valid
    end

    it 'is valid with a title < 250 characters' do
      subject.title = 'A' * 250
      expect(subject).to be_valid
    end

    it 'is not valid with a text > 5000 characters' do
      subject.text = 'Valid Text' * 1001
      expect(subject).to be_invalid
    end

    it 'is valid with a text < 5000 characters' do
      subject.text = 'Valid Text' * 100
      expect(subject).to be_valid
    end
  end

  # Method tests
  describe 'Methods' do
    it 'Returns empty if the post has no comments' do
      expect(subject.recent_5_comments).to eq([])
    end
  end
end
