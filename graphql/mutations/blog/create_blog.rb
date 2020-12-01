# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class CreateBlog < GraphQL::Schema::Mutation
      argument :user_id, Integer, required: true
      argument :name, String, required: true

      type Byg::Types::Blog

      def resolve(user_id:, name:)
        Byg::Models::Blog.create(user_id: user_id, name: name)
      end
    end
  end
end
