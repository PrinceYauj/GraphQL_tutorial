# frozen_string_literal: true

RSpec.describe Byg::Mutations::UpdateComment do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:comment) { create(:comment) }
    let(:args) { { id: comment.id, text: 'new text' } }

    it 'invokes Byg::Models::Comment.with_pk!(id).update with given args' do
      instance = object_double(comment)
      allow(comment.class).to receive(:with_pk!).with(comment.id).\
        and_return(instance)
      expect(instance).to receive(:update).with(args.slice(:text))
      execute
    end
  end
end
