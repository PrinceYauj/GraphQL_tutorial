# frozen_string_literal: true

module Byg
  module Types
    # GraphQL post type
    class Post < GraphQL::Schema::Object
      description 'Posts'
      require_relative 'comment_type'
      field :id, Integer, null: false
      field :blog, Blog, null: false
      field :text, String, null: false
      field :comments, [Comment], null: true
    end
  end
end
