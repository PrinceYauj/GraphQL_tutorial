# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateReaction < GraphQL::Schema::Mutation

      argument :comment_id, Integer, required: true
      argument :user_id, Integer, required: true
      argument :value, Integer, required: true

      type Byg::Types::Reaction

      def resolve(comment_id:, user_id:, value:)
        params = { comment_id: comment_id, user_id: user_id, value: value }
        Byg::Models::Reaction.create(params)
      end
    end
  end
end
