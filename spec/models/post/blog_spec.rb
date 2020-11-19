# frozen_string_literal: true

RSpec.describe Byg::Models::Post do
  it { is_expected.to respond_to(:blog).with(0).arguments }

  describe '.blog' do
    subject(:blog) { post.blog }

    let(:post) { create(:post) }

    it { is_expected.to be_a(Byg::Models::Blog) }
    it { expect(blog.id).to be == (post.blog_id) }
  end
end
