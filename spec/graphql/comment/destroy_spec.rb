# frozen_string_literal: true

RSpec.describe Byg::Mutations::DestroyComment do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql args' do
    let(:comment) { create(:comment) }
    let(:args) { { id: comment.id } }

    it 'invokes Byg::Models::Comment[id].destroy with corresponding id' do
      instance = object_double(comment)
      allow(comment.class).to receive(:with_pk!).with(comment.id).\
        and_return(instance)
      expect(instance).to receive(:destroy)
      execute
    end

    it 'destroys comment' do
      execute
      expect(Byg::Models::Comment[comment.id]).to be(nil)
    end
  end

  context 'when comment not exists' do
    let(:args) { { id: -1 } }

    it 'returns Sequel::NoMatchingRow error' do
      expect(errors[0]['message']).to eql("Sequel::NoMatchingRow")
    end
  end
end
