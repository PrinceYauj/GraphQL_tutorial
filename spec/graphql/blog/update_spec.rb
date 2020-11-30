# frozen_string_literal: true

RSpec.describe Byg::Mutations::UpdateBlog do
  include_context 'graphql'

  it { is_expected.to be_a(GraphQL::Schema::Mutation) }

  context 'with valid gql arguments' do
    let(:blog) { create(:blog) }
    let(:args) { { id: blog.id, name: 'new name' } }

    it 'invokes Byg::Models::Blog.with_pk!(id).update with given args' do
      instance = object_double(blog)
      allow(blog.class).to receive(:with_pk!).with(blog.id).and_return(instance)
      expect(instance).to receive(:update).with(args.slice(:name))
      execute
    end
  end
end
