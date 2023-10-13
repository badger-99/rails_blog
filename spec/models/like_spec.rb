require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'should create an instance of the Lke class' do
    author = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    audience = User.create(name: 'name2', photo: 'www.selfie.pic2', bio: 'bio2')
    post = Post.create(title: 'title', text: 'this is a test', author_id: author.id)
    like = Like.create(user_id: audience.id, post_id: post.id)
    expect(like).to be_instance_of(Like)
  end
end
