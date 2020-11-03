# frozen_string_literal: true

module Byg
  module Types
    class Comment < GraphQL::Schema::Object
      description 'Comments'
      require_relative 'reaction_type.rb'
      field :id, ID, null: false
      field :post, Post, null: false
      field :user, User, null: false
      field :text, String, null: false
      field :reactions, [Reaction], null: true
    end
  end
end
