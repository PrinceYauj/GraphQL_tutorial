# frozen_string_literal: true

require 'sequel'

module Byg
  module Models
    # reaction model. Belongs to the Comment. Belongs to the User. 
    # Has parameters :id, :comment_id, :user_id, :value
    # User can have only 1 reaction to certain comment
    # :value can be -1, 0 or 1
    class Reaction < Sequel::Model
      REACTION_RANGE = /^([01]|-1)\z/
      plugin :validation_helpers
      many_to_one :user
      many_to_one :comment

      def validate
        super
        validates_unique [:user_id, :comment_id]
        validates_numeric :value
        validate_format REACTION_RANGE, :value
      end
    end
  end
end
