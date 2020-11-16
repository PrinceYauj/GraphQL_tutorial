# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { is_expected.to respond_to(:user).with(0).arguments }

  describe '.user' do
    subject(:user) { blog.user }

    let(:blog) { create(:blog) }

    it { is_expected.to be_a(Byg::Models::User) }
    it { expect(user.id).to be == (blog.user_id) }
  end
end

