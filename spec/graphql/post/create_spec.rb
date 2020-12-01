# frozen_string_literal: true

RSpec.describe Byg::Mutations::CreatePost do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid for gql arguments' do
    let(:args) { { blogId: 1, text: 'asd' } }

    it 'invokes Byg::Models::Post.create method with corresponding args' do
      expect(Byg::Models::Post).to receive(:create).with(to_snake(args))
      execute
    end
  end

  context 'with invalid blogId and valid text' do
    let(:args) { { blogId: '', text: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'blogId' on Field" \
        " 'createPost' has an invalid value (\"\"). Expected type 'Int!'")
    end
  end

  context 'with valid blogId and invalid text' do
    let(:args) { { blogId: -1, text: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'text' on Field" \
        " 'createPost' has an invalid value (1). Expected type 'String!'")
    end
  end

  context 'with invalid arguments' do
    let(:args) { { blogId: '', text: 1 } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
    end
  end

  context 'with missing required argument' do
    let(:args) { { text: '' } }

    it 'returns 1 gql errors' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Field 'createPost' is" \
        ' missing required arguments: blogId')
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
      expect(errors[0]['message']).to include("Field 'createPost' is" \
        ' missing required arguments: blogId, text')
      expect(errors[1]['message']).to include("Field 'createPost' doesn't" \
        " accept argument 'non_existent_arg'")
    end
  end
end
