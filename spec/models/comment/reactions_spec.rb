# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:reactions).with(0).arguments }

  describe '.reactions' do
    subject(:reactions) { comment.reactions }

    let(:comment) { create(:comment, :with_reactions) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Reaction)) }

    it 'returns comment\'s associated reactions' do
      expect(reactions.map(&:comment_id).uniq).to be == [comment.id]
    end
  end
end

