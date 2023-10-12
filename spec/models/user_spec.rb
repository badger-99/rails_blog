require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validators' do
    subject { User.create(name: 'name', photo: 'www.selfie.pic', bio: 'bio') }

    it 'should be invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should be valid with a name' do
      subject.name = 'name'
      expect(subject).to be_valid
    end

    it 'should be invalid with a negative or non-zero post counter' do
      subject.posts_counter = nil
      expect(subject).to_not be_valid
    end

    it 'should be invalid with a negative or non-zero post counter' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should be valid with a integer equal to or greater than zero in the post counter' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  describe 'recent_users' do
    it 'orders users by created_at in descending order and limits to 3' do
      User.create(name: 'name1', photo: 'www.selfie1.pic', bio: 'bio1')
      u2 = User.create(name: 'name2', photo: 'www.selfie2.pic', bio: 'bio2')
      u3 = User.create(name: 'name3', photo: 'www.selfie3.pic', bio: 'bio3')
      u4 = User.create(name: 'name4', photo: 'www.selfie4.pic', bio: 'bio4')

      id2 = u2.id
      id3 = u3.id
      id4 = u4.id

      user2 = User.find(id2)
      user3 = User.find(id3)
      user4 = User.find(id4)

      recent_users = User.recent_users

      expect(recent_users).to match_array([user4, user3, user2])
    end
  end
end
