# frozen_string_literal: true

RSpec.describe Byg::Models::Post do
  it { is_expected.to respond_to(:destroy).with(0).arguments }

  describe '.destroy' do
    subject(:destroy) { post.destroy }

    let!(:post) { create(:post, :with_comments) }

    it 'destroys the post instance' do
      expect{ destroy }.to change{ described_class[post.id] }.to(nil)
    end

    it 'destroys post\'s comments (if any)' do
      expect{ destroy }.to change{ DB[:comments].count }.from(2).to(0)
    end
  end
end

