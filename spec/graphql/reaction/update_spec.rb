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

    it 'updates a reaction' do
      execute
      expect(reaction.class[reaction.id].values).to be > (args)
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
    let(:args) { { value: 0 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateReaction\'' \
        ' is missing required arguments: id')
    end
  end

  context 'with invalid type id' do
    let(:args) { { id: 'new id' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'id\' on Field' \
        ' \'updateReaction\' has an invalid value ("new id")')
    end
  end

  context 'with valid id and missing value' do
    let(:reaction) { create(:reaction) }
    let(:args) { { id: reaction.id } }

    it 'returns nil' do
      expect(execute.to_h['data']['updateReaction']).to be(nil)
    end
  end

  context 'with valid id and invalid type value' do
    let(:args) { { id: 1, value: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'value\' on Field' \
        ' \'updateReaction\' has an invalid value ("")')
    end
  end

  context 'with nonexisting argument' do
    let(:args) { { id: 1, non_existing_argument: 'any' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateReaction\'' \
        ' doesn\'t accept argument \'nonExistingArgument\'')
    end
  end
end
