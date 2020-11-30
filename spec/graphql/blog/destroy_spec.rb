# frozen_string_literal: true

RSpec.describe Byg::Mutations::DestroyBlog do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql args' do
    let(:blog) { create(:blog) }
    let(:args) { { id: blog.id } }

    it 'invokes Byg::Models::Blog[id].destroy method with corresponding id' do
      instance = object_double(blog)
      allow(blog.class).to receive(:with_pk!).with(blog.id).and_return(instance)
      expect(instance).to receive(:destroy)
      execute
    end

    it 'destroys blog' do
      execute
      expect(Byg::Models::Blog[blog.id]).to be(nil)
    end
  end

  context 'when blog not exists' do
    let(:args) { { id: -1 } }

    it 'returns Sequel::NoMatchingRow error' do
      expect(errors[0]['message']).to eql("Sequel::NoMatchingRow")
    end
  end
end
