# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateComment < GraphQL::Schema::Mutation
      argument :user_id, Integer, required: true
      argument :post_id, Integer, required: true
      argument :text, String, required: true

      type Byg::Types::Comment

      def resolve(user_id:, post_id:, text:)
        params = { user_id: user_id, post_id: post_id, text: text }
        Byg::Models::Comment.create(params)
      end
    end
  end
end
