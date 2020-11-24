# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreatePost < GraphQL::Schema::Mutation

      argument :text, String, required: true
      argument :blog_id, Integer, required: true

      type Byg::Types::Post

      def resolve(text:, blog_id:)
        Byg::Models::Post.create(text: text, blog_id: blog_id)
      end
    end
  end
end
