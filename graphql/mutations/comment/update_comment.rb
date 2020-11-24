# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateComment < GraphQL::Schema::Mutation

      argument :text, String, required: true

      type Byg::Types::Comment

      def resolve(text:)
        Byg::Models::Comment.update(text: text)
      end
    end
  end
end
