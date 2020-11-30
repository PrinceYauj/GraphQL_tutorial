# frozen_string_literal: true

RSpec.describe Byg::Mutations::DestroyPost do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql args' do
    let(:post) { create(:post) }
    let(:args) { { id: post.id } }

    it 'invokes Byg::Models::Post[id].destroy method with corresponding id' do
      instance = object_double(post)
      allow(post.class).to receive(:with_pk!).with(post.id).and_return(instance)
      expect(instance).to receive(:destroy)
      execute
    end

    it 'destroys post' do
      execute
      expect(Byg::Models::Post[post.id]).to be(nil)
    end
  end

  context 'when post not exists' do
    let(:args) { { id: -1 } }

    it 'returns Sequel::NoMatchingRow error' do
      expect(errors[0]['message']).to eql("Sequel::NoMatchingRow")
    end
  end
end
