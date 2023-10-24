require 'rails_helper'

RSpec.feature 'User Show Page elements', type: :feature do
  describe 'The user bio page' do
    before(:each) do
      @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
      @post1 = Post.create(title: 'Title 1', text: 'Post number 1 content.', author_id: @user.id)
      @post2 = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
      @post3 = Post.create(title: 'Title 3', text: 'Post number 3 content.', author_id: @user.id)
      @post4 = Post.create(title: 'Title 4', text: 'Post number 4 content.', author_id: @user.id)
      visit "/users/#{@user.id}"
    end

    context "The User's details, bio, recent posts, and 'See all posts' button are visble on the page" do
      it 'should show the name, profile picture, number of posts, and bio of the user' do
        expect(page).to have_css("img[src*='#{@user.photo}']")
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.posts_counter)
        expect(page).to have_content(@user.bio)
      end

      it 'should show the 3 newest posts' do
        posts = all('.postCard')
        expect(posts.count).to eq(3)
        expect(page).to have_no_content(@post1.title)
        expect(page).to have_content(@post2.title)
        expect(page).to have_content(@post3.title)
        expect(page).to have_content(@post4.title)
      end

      it 'should show a link to see all posts' do
        expect(page).to have_button('See all posts')
      end
    end
  end
end

RSpec.feature 'User Index show links', type: :feature do
    describe 'links to individual posts and all posts work' do
      before(:each) do
        @user = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
        @post1 = Post.create(title: 'Title 1', text: 'Post number 1 content.', author_id: @user.id)
        @post2 = Post.create(title: 'Title 2', text: 'Post number 2 content.', author_id: @user.id)
        @post3 = Post.create(title: 'Title 3', text: 'Post number 3 content.', author_id: @user.id)
        @post4 = Post.create(title: 'Title 4', text: 'Post number 4 content.', author_id: @user.id)
        visit "/users/#{@user.id}"
      end
  
      it 'should have a link redirecting to a page where you can see all posts' do
        expect(page).to have_link('See all posts', href: "/users/#{@user.id}/posts")
      end
  
      it "should have links on each of the post titles that lead to that post's main page" do
        expect(page).to have_link(@post2.title, href: "/users/#{@user.id}/posts/#{@post2.id}")
        expect(page).to have_link(@post3.title, href: "/users/#{@user.id}/posts/#{@post3.id}")
        expect(page).to have_link(@post4.title, href: "/users/#{@user.id}/posts/#{@post4.id}")
        expect(page).to have_no_link(@post1.title, href: "/users/#{@user.id}/posts/#{@post1.id}")
      end
    end
  end