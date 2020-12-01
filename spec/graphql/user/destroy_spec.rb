# frozen_string_literal: true

RSpec.describe Byg::Mutations::DestroyUser do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:user) { create(:user) }
    let(:args) { { id: user.id } }

    it 'invokes Byg::Models::User[id].destroy method with corresponding id' do
      instance = object_double(user)
      allow(user.class).to receive(:with_pk!).with(user.id).and_return(instance)
      expect(instance).to receive(:destroy)
      execute
    end

    it 'destroys user' do
      execute
      expect(Byg::Models::User[user.id]).to be(nil)
    end
  end

  context 'when user does not exist' do
    let(:args) { { id: -1 } }

    it 'returns Sequel::NoMatchingRow error' do
      expect(errors[0]['message']).to eql('Sequel::NoMatchingRow')
    end
  end
end
