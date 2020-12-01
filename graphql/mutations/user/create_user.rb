# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateUser < GraphQL::Schema::Mutation
      argument :name, String, required: true
      argument :email, String, required: true

      type Byg::Types::User

      def resolve(name:, email:)
        Byg::Models::User.create(name: name, email: email)
      end
    end
  end
end
