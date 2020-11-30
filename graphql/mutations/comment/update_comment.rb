# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateComment < GraphQL::Schema::Mutation

      argument :id, Integer, required: true
      argument :text, String, required: false

      type Byg::Types::Comment

      def resolve(id:, text:)
        Byg::Models::Comment.with_pk!(id).update(text: text)
      end
    end
  end
end
