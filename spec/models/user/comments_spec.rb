# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:comments).with(0).arguments }

  let!(:user) { user_with_comments(1) }

  it 'returns an array of Byg::Models::Comment instances' do
    expect(user.comments).to be_an(Array)
    expect(user.comments[0]).to be_a(Byg::Models::Comment)
  end
end

