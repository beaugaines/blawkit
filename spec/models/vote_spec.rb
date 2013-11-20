require 'spec_helper'

describe Vote do
  describe '#up_vote?' do
    it 'returns true for an upvote' do
      v = Vote.new(value: 1)
      expect(v.up_vote?).to be_true
    end
  end
end
