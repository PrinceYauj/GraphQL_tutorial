# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:user).with(0).arguments }

  describe '.user' do
    subject(:user) { comment.user }

    let(:comment) { create(:comment) }

    it { is_expected.to be_a(Byg::Models::User) }
    it { expect(user.id).to be == (comment.user_id) }
  end
end
