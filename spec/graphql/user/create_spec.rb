# frozen_string_literal: true

RSpec.describe Byg::Mutations::CreateUser do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:args) { { name: '', email: '' } }

    it 'invokes Byg::Models::User.create method with corresponding args' do
      expect(Byg::Models::User).to receive(:create).with(args)
      execute
    end
  end

  context 'with invalid name and valid email' do
    let(:args) { { name: 1, email: '' } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'name' on Field" \
        " 'createUser' has an invalid value (1). Expected type 'String!'")
    end
  end

  context 'with valid name and invalid email' do
    let(:args) { { name: '', email: 1 } }

    it 'returns 1 gql error' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Argument 'email' on Field" \
        " 'createUser' has an invalid value (1). Expected type 'String!'")
    end
  end

  context 'with invalid arguments' do
    let(:args) { { name: 1, email: 1 } }

    it 'returns 2 gql errors' do
      expect(errors.count).to be == 2
    end
  end

  context 'with missing required argument' do
    let(:args) { { name: '' } }

    it 'returns 1 gql errors' do
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include("Field 'createUser' is" \
        ' missing required arguments: email')
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
      expect(errors[0]['message']).to include("Field 'createUser' is" \
        ' missing required arguments: name, email')
      expect(errors[1]['message']).to include("Field 'createUser' doesn't" \
        " accept argument 'non_existent_arg'")
    end
  end

  context 'with not unique name and email' do
    let(:args) { { name: 'AAA', email: 'a@a.asd' } }

    it 'returns 1 gql(sequel) errors' do
      create(:user, args)
      expect(errors.count).to be == 1
      expect(errors[0]['message']).to include('name is already taken,' \
        ' email is already taken')
    end
  end
end
