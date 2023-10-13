require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should create an instance of the Comment class' do
    author = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    audience = User.create(name: 'name2', photo: 'www.selfie.pic2', bio: 'bio2')
    post = Post.create(title: 'title', text: 'this is a test', author_id: author.id)
    comment = Comment.create(text: 'comment', user_id: audience.id, post_id: post.id)
    expect(comment).to be_instance_of(Comment)
  end
end
