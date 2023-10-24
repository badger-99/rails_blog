require 'rails_helper'

RSpec.feature 'Author and Post Info in Post Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    @post1 = Post.create(title: 'Title 1', text: 'Post number 1 content.', author_id: @user.id)
    @post2 = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
    @post3 = Post.create(title: 'Title 3', text: 'Post number 3 content.', author_id: @user.id)
    @post4 = Post.create(title: 'Title 4', text: 'Post number 4 content.', author_id: @user.id)
    visit "/users/#{@user.id}/posts"
  end

  it 'should show the name, profile picture, and number of posts of the user' do
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'should show the title and some of the body of only the two most recent posts on the first page' do
    expect(page).to have_content(@post4.title)
    expect(page).to have_content(@post4.text)
    expect(page).to have_content(@post3.title)
    expect(page).to have_content(@post3.text)
    expect(page).to have_no_content(@post1.title)
    expect(page).to have_no_content(@post1.text)
    expect(page).to have_no_content(@post2.title)
    expect(page).to have_no_content(@post2.text)
  end
end
