# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateReaction < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :value, Integer, required: false

      type Byg::Types::Reaction

      def resolve(id:, value: nil)
        args = { value: value }.delete_if { |_, v| v.nil? }
        Byg::Models::Reaction.with_pk!(id).update(args)
      end
    end
  end
end
