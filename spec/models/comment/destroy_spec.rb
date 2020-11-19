# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:destroy).with(0).arguments }

  describe '.destroy' do
    subject(:destroy) { comment.destroy }

    let!(:comment) { create(:comment, :with_reactions) }

    it 'destroys the comment instance' do
      expect { destroy }.to change { described_class[comment.id] }.to(nil)
    end

    it 'destroys comment\'s reactions (if any)' do
      expect { destroy }.to change { DB[:reactions].count }.from(2).to(0)
    end
  end
end
