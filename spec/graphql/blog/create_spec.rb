# frozen_string_literal: true

RSpec.describe Byg::Mutations::CreateBlog do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:args) { { userId: 1, name: 'asd' } }

    it 'invokes Byg::Models::Blog.create method with corresponding args' do
      expect(Byg::Models::Blog).to receive(:create).with(to_snake(args))
      execute
    end
  end

  context 'with invalid userId and valid name' do
    let(:args) { { userId: '', name: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'userId' on Field" \
        " 'createBlog' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid userId and invalid name' do
    let(:args) { { userId: -1, name: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'name' on Field" \
        " 'createBlog' has an invalid value (1). Expected type 'String!'")
    end
  end

  context 'with invalid arguments' do
    let(:args) { { userId: '', name: 1 } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
    end
  end

  context 'with missing required argument' do
    let(:args) { { name: '' } }

    it 'returns 1 gql errors' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Field 'createBlog' is" \
        ' missing required arguments: userId')
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
    let(:args) { { non_existent_arg: 'any' } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
      expect(errors[0]['message']).to include("Field 'createBlog' is" \
        ' missing required arguments: userId, name')
      expect(errors[1]['message']).to include("Field 'createBlog' doesn't" \
        " accept argument 'nonExistentArg'")
    end
  end
end
