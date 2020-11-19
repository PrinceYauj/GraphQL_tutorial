# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:blogs).with(0).arguments }

  describe '.blogs' do
    subject(:blogs) { user.blogs }

    let(:user) { user_with_blogs(2) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Blog)) }

    it 'returns user\'s associated blogs' do
      expect(blogs.map(&:user_id).uniq).to be == [user.id]
    end
  end
end
