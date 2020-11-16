# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:post).with(0).arguments }

  describe '.post' do
    subject(:post) { comment.post }

    let(:comment) { create(:comment) }

    it { is_expected.to be_a(Byg::Models::Post) }
    it { expect(post.id).to be == (comment.post_id) }
  end
end

