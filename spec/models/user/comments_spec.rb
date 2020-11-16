# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:comments).with(0).arguments }

  describe '.comments' do
    subject(:comments) { user.comments }

    let(:user) { user_with_comments(2) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Comment)) }

    it 'returns user\'s associated comments' do
      expect(comments.map(&:user_id).uniq).to be == [user.id]
    end
  end
end

