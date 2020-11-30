# frozen_string_literal: true

RSpec.describe Byg::Mutations::UpdateUser do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:user) { create(:user) }
    let(:args) { { id: user.id, name: 'new name', email: 'new@email.com' } }

    it 'invokes Byg::Models::User.with_pk!(id).update with given args' do
      instance = object_double(user)
      allow(user.class).to receive(:with_pk!).with(user.id).and_return(instance)
      expect(instance).to receive(:update).with(args.slice(:name, :email))
      execute
    end
  end
end
