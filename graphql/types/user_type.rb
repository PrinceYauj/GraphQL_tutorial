# frozen_string_literal: true

module Byg
  module Types
    class User < GraphQL::Schema::Object
      description 'User'
      require_relative 'blog_type.rb'
      field :id, ID, null: false
      field :name, String, null: false
      field :email, String, null: false
      field :karma, Integer, null: false
      field :blogs, [Blog], null: true
    end
  end
end