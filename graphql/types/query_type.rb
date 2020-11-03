# frozen_string_literal: true

module Byg
  module Types
    class QueryType < GraphQL::Schema::Object
      description 'the query root of a schema'
      field :user, User, null: true do
        description 'find a user by ID'
        argument :id, ID, required: true
      end

      def user(id:)
        ::Byg::Models::User[id.to_i]
      end
    end
  end
end