# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:posts).with(0).arguments }

  describe '.posts' do
    subject(:posts) { user.posts }

    let(:user) { user_with_posts(2) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Post)) }

    it 'returns user\'s associated posts' do
      expect(posts.map(&:blog).map(&:user_id).uniq).to be == [user.id]
    end
  end
end
