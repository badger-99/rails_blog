require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validators' do
    demo = User.create(name: 'name', photo: 'www.selfie.pic', bio: 'bio')
    subject { Post.create(title: 'title', text: 'this is a test', author_id: demo.id) }

    it 'should be invalid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should be valid with a title' do
      subject.title = 'title'
      expect(subject).to be_valid
    end

    it 'should not have a title that is more than 250 characters long' do
      subject.title = 't' * 251
      expect(subject).to_not be_valid
    end

    it 'should have a title that is equal to or less than 250 characters long' do
      subject.title = 't' * 250
      expect(subject).to be_valid
    end

    it 'should be invalid with a negative or non-zero comment counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be valid with a integer equal to or greater than zero in the comment counter' do
      subject.comments_counter = 0
      expect(subject).to be_valid
    end

    it 'should be invalid with a negative or non-zero like counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be valid with a integer equal to or greater than zero in the like counter' do
      subject.likes_counter = 0
      expect(subject).to be_valid
    end
  end

  describe 'recent_comments' do
    it 'returns the 5 most recent comments on a post' do
      author = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
      audience = User.create(name: 'name2', photo: 'www.selfie.pic2', bio: 'bio2')
      post = Post.create(title: 'title', text: 'this is a test', author_id: author.id)

      Comment.create(text: 'comment', user_id: audience.id, post_id: post.id)
      comment1 = Comment.create(text: 'comment1', user_id: audience.id, post_id: post.id)
      comment2 = Comment.create(text: 'comment2', user_id: audience.id, post_id: post.id)
      comment3 = Comment.create(text: 'comment3', user_id: audience.id, post_id: post.id)
      comment4 = Comment.create(text: 'comment4', user_id: audience.id, post_id: post.id)
      comment5 = Comment.create(text: 'comment5', user_id: audience.id, post_id: post.id)

      result_comments = [comment5, comment4, comment3, comment2, comment1]

      expect(post.recent_comments).to match_array(result_comments)
    end
  end
end
