# frozen_string_literal: true

RSpec.describe Byg::Mutations::CreateComment do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid for gql arguments' do
    let(:args) { { userId: 1, postId: 1, text: 'asd' } }

    it 'invokes Byg::Models::Comment.create method with corresponding args' do
      expect(Byg::Models::Comment).to receive(:create).with(to_snake(args))
      execute
    end
  end

  context 'with invalid userId, valid postId and text' do
    let(:args) { { userId: '', postId: 1, text: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'userId' on Field" +
        " 'createComment' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid userId, invalid postId and valid text' do
    let(:args) { { userId: 1, postId: '', text: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'postId' on Field" +
        " 'createComment' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid userId and postId and invalid text' do
    let(:args) { { userId: 1, postId: 1, text: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'text' on Field" +
        " 'createComment' has an invalid value (1). Expected type 'String!'")
    end
  end

  context 'with invalid arguments' do
    let(:args) { { userId: '', postId: '', text: 1  } }

    it 'returns 3 gql errors' do
      expect(errors.count).to be == 3
    end
  end

  context 'with missing required arguments' do
    let(:args) { { text: '' } }

    it 'returns 1 gql errors' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Field 'createComment' is" +
        " missing required arguments: userId, postId")
    end
  end

  context 'with empty hash as an arguments' do
    let(:args) { {} }

    it 'returns parsing error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Parse error")
    end
  end

  context 'with non-existent argument' do
    let(:args) { { non_existent_arg: 'any'  } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
      expect(errors[0]['message']).to include("Field 'createComment' is" +
        " missing required arguments: userId, postId, text")
      expect(errors[1]['message']).to include("Field 'createComment' doesn't" +
        " accept argument 'non_existent_arg'")
    end
  end
end

