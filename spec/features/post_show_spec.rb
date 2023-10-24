require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    @commentor = User.create(name: 'name2', photo: 'www.selfie.pic2', bio: 'bio2')
    @post = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
    Like.create(user_id: @user.id, post_id: @post.id)
    Like.create(user_id: @commentor.id, post_id: @post.id)
    @comment1 = Comment.create(text: 'comment1', user_id: @commentor.id, post_id: @post.id)
    @comment2 = Comment.create(text: 'comment2', user_id: @commentor.id, post_id: @post.id)
    @comment3 = Comment.create(text: 'comment3', user_id: @commentor.id, post_id: @post.id)
    @comment4 = Comment.create(text: 'comment4', user_id: @commentor.id, post_id: @post.id)
    @comment5 = Comment.create(text: 'comment5', user_id: @commentor.id, post_id: @post.id)
    @post.reload
    visit "/users/#{@user.id}/posts"
  end

  it "should show the post's title, author and text" do
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.text)
  end

  it 'should show the number of comments and likes' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'should show the name of the commentor and the comment text' do
    expect(page).to have_content("#{@commentor.name}: #{@comment1.text}")
    expect(page).to have_content("#{@commentor.name}: #{@comment2.text}")
    expect(page).to have_content("#{@commentor.name}: #{@comment3.text}")
    expect(page).to have_content("#{@commentor.name}: #{@comment4.text}")
    expect(page).to have_content("#{@commentor.name}: #{@comment5.text}")
  end
end
