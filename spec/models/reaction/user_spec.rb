# frozen_string_literal: true

RSpec.describe Byg::Models::Reaction do
  it { is_expected.to respond_to(:user).with(0).arguments }

  describe '.user' do
    subject(:user) { reaction.user }

    let(:reaction) { create(:reaction) }

    it { is_expected.to be_a(Byg::Models::User) }
    it { expect(user.id).to be == (reaction.user_id) }
  end
end

