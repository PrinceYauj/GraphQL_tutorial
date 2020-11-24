# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateReaction < GraphQL::Schema::Mutation

      argument :value, Integer, required: true

      type Byg::Types::Reaction

      def resolve(value:)
        Byg::Models::Reaction.update(value: value)
      end
    end
  end
end
