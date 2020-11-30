# frozen_string_literal: true

RSpec.describe Byg::Mutations::DestroyReaction do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql args' do
    let(:reaction) { create(:reaction) }
    let(:args) { { id: reaction.id } }

    it 'invokes Byg::Models::Reaction[id].destroy with corresponding id' do
      instance = object_double(reaction)
      allow(reaction.class).to receive(:with_pk!).with(reaction.id).\
        and_return(instance)
      expect(instance).to receive(:destroy)
      execute
    end

    it 'destroys reaction' do
      execute
      expect(Byg::Models::Reaction[reaction.id]).to be(nil)
    end
  end

  context 'when reaction not exists' do
    let(:args) { { id: -1 } }

    it 'returns Sequel::NoMatchingRow error' do
      expect(errors[0]['message']).to eql("Sequel::NoMatchingRow")
    end
  end
end
