# frozen_string_literal: true

RSpec.describe Byg::Models::Reaction do
  it { is_expected.to respond_to(:destroy).with(0).arguments }

  describe '.destroy' do
    subject(:destroy) { reaction.destroy }

    let!(:reaction) { create(:reaction) }

    it 'destroys the reaction instance' do
      expect { destroy }.to change { described_class[reaction.id] }.to(nil)
    end
  end
end
