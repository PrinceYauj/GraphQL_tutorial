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

    it 'updates a comment' do
      execute
      expect(comment.class[comment.id].values).to be > (args)
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
    let(:args) { { text: 'new text' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateComment\'' \
        ' is missing required arguments: id')
    end
  end

  context 'with invalid type id' do
    let(:args) { { id: 'new id' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'id\' on Field' \
        ' \'updateComment\' has an invalid value ("new id")')
    end
  end

  context 'with valid id and missing text' do
    let(:comment) { create(:comment) }
    let(:args) { { id: comment.id } }

    it 'returns nil' do
      expect(execute.to_h['data']['updateComment']).to be(nil)
    end
  end

  context 'with valid id and invalid type text' do
    let(:args) { { id: 1, text: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Argument \'text\' on Field' \
        ' \'updateComment\' has an invalid value (1)')
    end
  end

  context 'with nonexisting argument' do
    let(:args) { { id: 1, non_existing_argument: 'any' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Field \'updateComment\' doesn\'t' \
        ' accept argument \'nonExistingArgument\'')
    end
  end
end
