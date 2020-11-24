# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateComment < GraphQL::Schema::Mutation

      argument :text, String, required: true
      argument :post_id, Integer, required: true
      argument :user_id, Integer, required: true

      type Byg::Types::Comment

      def resolve(text:, post_id:, user_id:)
        params = { text: text, post_id: post_id, user_id: user_id }
        Byg::Models::Comment.create(params)
      end
    end
  end
end
