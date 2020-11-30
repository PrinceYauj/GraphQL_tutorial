# frozen_string_literal: true

RSpec.describe Byg::Mutations::UpdateReaction do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:reaction) { create(:reaction) }
    let(:args) { { id: reaction.id, value: 0 } }

    it 'invokes Byg::Models::Reaction.with_pk!(id).update with given args' do
      instance = object_double(reaction)
      allow(reaction.class).to receive(:with_pk!).with(reaction.id).\
        and_return(instance)
      expect(instance).to receive(:update).with(args.slice(:value))
      execute
    end
  end
end
