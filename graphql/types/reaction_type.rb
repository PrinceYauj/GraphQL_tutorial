# frozen_string_literal: true

module Byg
  module Types
    # GraphQL reaction type
    class Reaction < GraphQL::Schema::Object
      description 'Reactions'
      field :id, ID, null: false
      field :comment, Comment, null: false
      field :user, User, null: false
      field :value, Integer, null: false
    end
  end
end
