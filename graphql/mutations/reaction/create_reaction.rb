# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateReaction < GraphQL::Schema::Mutation

      argument :user_id, Integer, required: true
      argument :comment_id, Integer, required: true
      argument :value, Integer, required: true

      type Byg::Types::Reaction

      def resolve(user_id:, comment_id:, value:)
        params = { user_id: user_id, comment_id: comment_id, value: value }
        Byg::Models::Reaction.create(params)
      end
    end
  end
end
