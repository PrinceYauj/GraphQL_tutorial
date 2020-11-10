# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:blogs).with(0).arguments }

  let!(:user) { user_with_blogs(1) }

  it 'returns an array of Byg::Models::Blog instances' do
    expect(user.blogs).to be_an(Array)
    expect(user.blogs[0]).to be_a(Byg::Models::Blog)
  end
end
