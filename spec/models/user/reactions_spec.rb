# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:reactions).with(0).arguments }

  let!(:user) { user_with_reactions(1) }

  it 'returns an array of Byg::Models::Reaction instances' do
    expect(user.reactions).to be_an(Array)
    expect(user.reactions[0]).to be_a(Byg::Models::Reaction)
  end
end

