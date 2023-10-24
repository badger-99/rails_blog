require 'rails_helper'

RSpec.feature 'User Index Page Elements', type: :feature do
  describe 'The user index page with 4 users' do
    before(:each) do
      @user1 = User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1', posts_counter: 2)
      @user2 = User.create(name: 'name2', photo: 'www.selfie2.pic', bio: 'bio2', posts_counter: 4)
      @user3 = User.create(name: 'name3', photo: 'www.selfie3.pic', bio: 'bio3', posts_counter: 6)
      @user4 = User.create(name: 'name4', photo: 'www.selfie4.pic', bio: 'bio4', posts_counter: 8)
      visit '/users'
    end

    context 'All user details are visble on the page' do
      it 'should show the name of each user' do
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
        expect(page).to have_content(@user4.name)
      end

      it 'should show the profile picture of eash user' do
        expect(page).to have_css("img[src*='#{@user1.photo}']")
        expect(page).to have_css("img[src*='#{@user2.photo}']")
        expect(page).to have_css("img[src*='#{@user3.photo}']")
        expect(page).to have_css("img[src*='#{@user4.photo}']")
      end

      it 'should show the number of posts each user has writen' do
        expect(page).to have_content(@user1.posts_counter)
        expect(page).to have_content(@user2.posts_counter)
        expect(page).to have_content(@user3.posts_counter)
        expect(page).to have_content(@user4.posts_counter)
      end
    end
  end
end