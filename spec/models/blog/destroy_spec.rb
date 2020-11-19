# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { is_expected.to respond_to(:destroy).with(0).arguments }

  describe '.destroy' do
    subject(:destroy) { blog.destroy }

    let!(:blog) { create(:blog, :with_posts) }

    it 'destroys the blog instance' do
      expect { destroy }.to change { described_class[blog.id] }.to(nil)
    end

    it 'destroys blog\'s posts (if any)' do
      expect { destroy }.to change { DB[:posts].count }.from(2).to(0)
    end
  end
end
