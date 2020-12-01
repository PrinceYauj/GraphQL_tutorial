# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdatePost < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :text, String, required: false

      type Byg::Types::Post

      def resolve(id:, text:)
        Byg::Models::Post.with_pk!(id).update(text: text)
      end
    end
  end
end
