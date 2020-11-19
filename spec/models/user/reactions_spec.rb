# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:reactions).with(0).arguments }

  describe '.reactions' do
    subject(:reactions) { user.reactions }

    let(:user) { user_with_reactions(2) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Reaction)) }

    it 'returns user\'s associated reactions' do
      expect(reactions.map(&:user_id).uniq).to be == [user.id]
    end
  end
end
