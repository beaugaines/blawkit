require 'spec_helper'

describe User do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe '.top_rated' do

    before(:each) do
      post = nil
      topic = create(:topic)
      @u1 = create(:user) do |user|
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end

      @u2 = create(:user) do |user|
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end
    end

    it 'returns users based on comments + posts' do
      expect(User.top_rated).to eq([@u2, @u1])
    end

    before(:each) do
      @users = User.top_rated
    end


    it 'has posts_count on user' do
      expect(@users.first.posts_count).to eq(1)
    end

    it 'has comments_count on user' do
      expect(@users.first.comments_count).to eq(2)
    end
  end
end
