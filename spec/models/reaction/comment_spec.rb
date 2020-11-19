# frozen_string_literal: true

RSpec.describe Byg::Models::Reaction do
  it { is_expected.to respond_to(:comment).with(0).arguments }

  describe '.comment' do
    subject(:comment) { reaction.comment }

    let(:reaction) { create(:reaction) }

    it { is_expected.to be_a(Byg::Models::Comment) }
    it { expect(comment.id).to be == (reaction.comment_id) }
  end
end
