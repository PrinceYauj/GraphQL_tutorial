# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreatePost < GraphQL::Schema::Mutation
      argument :blog_id, Integer, required: true
      argument :text, String, required: true

      type Byg::Types::Post

      def resolve(blog_id:, text:)
        Byg::Models::Post.create(blog_id: blog_id, text: text)
      end
    end
  end
end
