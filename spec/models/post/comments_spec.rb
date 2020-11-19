# frozen_string_literal: true

RSpec.describe Byg::Models::Post do
  it { is_expected.to respond_to(:comments).with(0).arguments }

  describe '.comments' do
    subject(:comments) { post.comments }

    let(:post) { create(:post, :with_comments) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Byg::Models::Comment)) }

    it 'returns post\'s associated comments' do
      expect(comments.map(&:post_id).uniq).to be == [post.id]
    end
  end
end
