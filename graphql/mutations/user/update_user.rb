# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateUser < GraphQL::Schema::Mutation
      argument :id, Integer, required: true
      argument :name, String, required: false
      argument :email, String, required: false

      type Byg::Types::User

      def resolve(id:, name:, email:)
        Byg::Models::User.with_pk!(id).update(name: name, email: email)
      end
    end
  end
end
