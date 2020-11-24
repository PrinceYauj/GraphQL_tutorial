# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdatePost < GraphQL::Schema::Mutation

      argument :text, String, required: true

      type Byg::Types::Post

      def resolve(text:)
        Byg::Models::Post.update(text: text)
      end
    end
  end
end
