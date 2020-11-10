# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:posts).with(0).arguments }

  let!(:user) { user_with_posts(1) }

  it 'returns an array of Byg::Models::Post instances' do
    expect(user.posts).to be_an(Array)
    expect(user.posts[0]).to be_a(Byg::Models::Post)
  end
end

