# frozen_string_literal: true

module Byg
  module Models
    # blog model. Belongs to the User. Has many posts
    # Has parameters :id, :user_id, :name
    class Blog < Sequel::Model
      plugin :validation_helpers
      many_to_one :user
      one_to_many :posts

      def validate
        super
        validates_presence %i[name user_id]
      end
    end
  end
end
