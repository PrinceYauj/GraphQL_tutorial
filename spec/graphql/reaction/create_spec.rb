# frozen_string_literal: true

RSpec.describe Byg::Mutations::CreateReaction do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid for gql arguments' do
    let(:args) { { userId: 1, commentId: 1, value: 1 } }

    it 'invokes Byg::Models::Reaction.create method with corresponding args' do
      expect(Byg::Models::Reaction).to receive(:create).with(to_snake(args))
      execute
    end
  end

  context 'with invalid userId, valid commentId and value' do
    let(:args) { { userId: '', commentId: 1, value: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'userId' on Field" \
        " 'createReaction' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid userId, invalid commentId and valid value' do
    let(:args) { { userId: 1, commentId: '', value: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'commentId' on Field" \
        " 'createReaction' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid userId and commentId and invalid value' do
    let(:args) { { userId: 1, commentId: 1, value: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'value' on Field" \
        " 'createReaction' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with invalid arguments' do
    let(:args) { { userId: '', commentId: '', value: '' } }

    it 'returns 3 gql errors' do
      expect(errors.count).to be == 3
    end
  end

  context 'with missing required arguments' do
    let(:args) { { value: 1 } }

    it 'returns 1 gql errors' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Field 'createReaction' is" \
        ' missing required arguments: userId, commentId')
    end
  end

  context 'with empty hash as an arguments' do
    let(:args) { {} }

    it 'returns parsing error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('Parse error')
    end
  end

  context 'with non-existent argument' do
    let(:args) { { nonExistentArg: 'any' } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
      expect(errors[0]['message']).to include("Field 'createReaction' is" \
        ' missing required arguments: userId, commentId, value')
      expect(errors[1]['message']).to include("Field 'createReaction' doesn't" \
        " accept argument 'nonExistentArg'")
    end
  end
end
