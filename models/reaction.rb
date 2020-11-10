# frozen_string_literal: true

module Byg
  module Models
    # reaction model. Belongs to the Comment. Belongs to the User. 
    # Has parameters :id, :comment_id, :user_id, :value
    # A pair [comment_id, user_id] must be unique
    # :value can be -1, 0 or 1, implemented with check DB constraint
    class Reaction < Sequel::Model
      plugin :validation_helpers
      many_to_one :user
      many_to_one :comment

      def validate
        super
        validates_unique [:user_id, :comment_id]
      end
    end
  end
end
