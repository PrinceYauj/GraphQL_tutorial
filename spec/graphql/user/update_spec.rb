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

    it 'updates a user' do
      execute
      expect(user.class[user.id].values).to be > (args)
    end
  end

  context 'with invalid id' do
    let(:args) { { id: -1 } }

    it 'returns "no matching row" error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Sequel::NoMatchingRow')
    end
  end

  context 'with missing id' do
    let(:args) { { name: 'new name', email: 'new@email.com' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateUser\'' \
        ' is missing required arguments: id')
    end
  end

  context 'with invalid type id' do
    let(:args) { { id: 'new id' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'id\' on Field' \
        ' \'updateUser\' has an invalid value ("new id")')
    end
  end

  context 'with valid id and missing name, email' do
    let(:user) { create(:user) }
    let(:args) { { id: user.id } }

    it 'returns nil' do
      expect(execute.to_h['data']['updateUser']).to be(nil)
    end
  end

  context 'with valid id and invalid type name' do
    let(:args) { { id: 1, name: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'name\' on Field' \
        ' \'updateUser\' has an invalid value (1)')
    end
  end

  context 'with valid id and invalid type email' do
    let(:args) { { id: 1, email: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'email\' on Field' \
        ' \'updateUser\' has an invalid value (1)')
    end
  end

  context 'with nonexisting argument' do
    let(:args) { { id: 1, non_existing_argument: 'any' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateUser\' doesn\'t' \
        ' accept argument \'nonExistingArgument\'')
    end
  end
end
