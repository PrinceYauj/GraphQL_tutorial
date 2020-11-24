# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class UpdateUser < GraphQL::Schema::Mutation

      argument :name, String, required: false
      argument :email, String, required: false

      type Byg::Types::User

      def resolve(name:, email:)
        Byg::Models::User.update(name: name, email: email)
      end
    end
  end
end
