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

RSpec.feature 'Comments and Likes counter on a post in the Post Index Page', type: :feature do
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
    @comment6 = Comment.create(text: 'comment6', user_id: @commentor.id, post_id: @post.id)
    @post.reload
    visit "/users/#{@user.id}/posts"
  end

  describe 'recent comments, comment counter, likes counter' do
    it 'should show 5 most recent comments, comment counter, and likes counter' do
      @post_with_comments = find('.indexPost')
      result_comments = [@comment6.text, @comment5.text, @comment4.text, @comment3.text, @comment2.text]

      result_comments.each do |comment|
        expect(@post_with_comments).to have_content(comment)
      end

      expect(@post_with_comments).to have_no_content(@comment1.text)
      expect(@post_with_comments).to have_content("Comments: #{@post.comments_counter}")
      expect(@post_with_comments).to have_content("Likes: #{@post.likes_counter}")
    end
  end
end

RSpec.feature 'Pagination links in the Post Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    @post1 = Post.create(title: 'Title 1', text: 'Post number 1 content.', author_id: @user.id)
    @post2 = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
    @post3 = Post.create(title: 'Title 3', text: 'Post number 3 content.', author_id: @user.id)
    @post4 = Post.create(title: 'Title 4', text: 'Post number 4 content.', author_id: @user.id)
  end

  describe 'Pagination links in the first page' do
    it 'should show active links to page2 and next' do
      visit "/users/#{@user.id}/posts"
      expect(page).to have_link('2', href: "/users/#{@user.id}/posts?page=2")
      expect(page).to have_link('Next →', href: "/users/#{@user.id}/posts?page=2")
    end
  end

  describe 'Pagination links in the second page' do
    it 'should show active links to page1 and next' do
      visit "/users/#{@user.id}/posts?page=2"
      expect(page).to have_link('1', href: "/users/#{@user.id}/posts?page=1")
      expect(page).to have_link('← Previous', href: "/users/#{@user.id}/posts?page=1")
    end
  end
end

RSpec.feature 'Links to main Post page from the Post Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
    @post1 = Post.create(title: 'Title 1', text: 'Post number 1 content.', author_id: @user.id)
    @post2 = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
    visit "/users/#{@user.id}/posts"
  end

  describe 'Links to main post page' do
    it 'should Link to the main post page' do
      expect(page).to have_link(@post1.title, href: "/users/#{@user.id}/posts/#{@post1.id}")
      expect(page).to have_link(@post2.title, href: "/users/#{@user.id}/posts/#{@post2.id}")
    end
  end
end
