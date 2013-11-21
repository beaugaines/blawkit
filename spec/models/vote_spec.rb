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
      Post.skip_callback(:create, :after, :create_vote)
      p = Post.new
      u = User.new
      p.save(validate: false)
      u.save(validate: false)
      expect(p).to receive(:update_rank)
      u.votes.create(value: 1, post: p)
      Post.set_callback(:create, :after, :create_vote)
    end
  end
end
