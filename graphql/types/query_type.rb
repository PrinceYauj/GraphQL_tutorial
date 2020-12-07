# frozen_string_literal: true

module Byg
  module Types
    # NODOC
    class QueryType < GraphQL::Schema::Object
      description 'the query root of a schema'
      field :user, User, null: true do
        description 'find a user by ID'
        argument :id, Integer, required: true
      end

      def user(id:)
        ::Byg::Models::User.with_pk!(id)
      end
    end
  end
end
