require 'spec_helper'

describe Vote do
  describe '#up_vote?' do
    it 'returns true for an upvote' do
      v = Vote.new(value: 1)
      expect(v.up_vote?).to be_true
    end

    it 'returns false for a downvote' do
      v = Vote.new(value: -1)
      expect(v.up_vote?).to be_false
    end
  end

  describe '#down_vote?' do
    it 'returns true for a downvote' do
      v = Vote.new(value: -1)
      expect(v.down_vote?).to be_true
    end

    it 'returns false for a upvote' do
      v = Vote.new(value: 1)
      expect(v.down_vote?).to be_false
    end
  end

  describe '#update_post' do
    it 'calls update_rank on post' do
      post = create(:post)
      user = create(:user)
      expect(post).to receive(:update_rank)
      user.votes.create(value: 1, post: post)
    end
  end
end
