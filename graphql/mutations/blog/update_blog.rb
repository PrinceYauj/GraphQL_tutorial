# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateBlog < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :name, String, required: false

      type Byg::Types::Blog

      def resolve(id:, name:)
        Byg::Models::Blog.with_pk!(id).update(name: name)
      end
    end
  end
end
