# frozen_string_literal: true

RSpec.describe Byg::Mutations::UpdatePost do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:post) { create(:post) }
    let(:args) { { id: post.id, text: 'new text' } }

    it 'invokes Byg::Models::Post.with_pk!(id).update with given args' do
      instance = object_double(post)
      allow(post.class).to receive(:with_pk!).with(post.id).and_return(instance)
      expect(instance).to receive(:update).with(args.slice(:text))
      execute
    end
  end
end
