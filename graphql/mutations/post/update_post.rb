# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdatePost < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :text, String, required: false

      type Byg::Types::Post

      def resolve(id:, text: nil)
        args = { text: text }.delete_if { |_, v| v.nil? }
        Byg::Models::Post.with_pk!(id).update(args)
      end
    end
  end
end
