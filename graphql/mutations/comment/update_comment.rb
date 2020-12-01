# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateComment < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :text, String, required: false

      type Byg::Types::Comment

      def resolve(id:, text: nil)
        args = { text: text }.delete_if { |_, v| v.nil? }
        Byg::Models::Comment.with_pk!(id).update(args)
      end
    end
  end
end
