# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { is_expected.to respond_to(:posts).with(0).arguments }

  describe '.posts' do
    subject(:posts) { blog.posts }

    let(:blog) { create(:blog, :with_posts) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Post)) }

    it 'returns blog\'s associated posts' do
      expect(posts.map(&:blog_id).uniq).to be == [blog.id]
    end
  end
end
