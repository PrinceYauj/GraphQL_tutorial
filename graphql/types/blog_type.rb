# frozen_string_literal: true

module Byg
  module Types
    # GraphQL blog type
    class Blog < GraphQL::Schema::Object
      description 'Blogs'
      require_relative 'post_type'
      field :id, Integer, null: false
      field :user, User, null: false
      field :name, String, null: false
      field :posts, [Post], null: true
    end
  end
end
