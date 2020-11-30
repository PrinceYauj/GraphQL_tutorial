# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateReaction < GraphQL::Schema::Mutation

      argument :id, Integer, required: true
      argument :value, Integer, required: false

      type Byg::Types::Reaction

      def resolve(id:, value:)
        Byg::Models::Reaction.with_pk!(id).update(value: value)
      end
    end
  end
end
