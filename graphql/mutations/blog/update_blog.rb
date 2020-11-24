# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateBlog < GraphQL::Schema::Mutation

      argument :name, String, required: true

      type Byg::Types::Blog

      def resolve(name:)
        Byg::Models::Blog.update(name: name)
      end
    end
  end
end
