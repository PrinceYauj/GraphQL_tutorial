# frozen_string_literal: true

require 'sequel'

module Byg
  module Models
    # blog model. Belongs to the User. Has many posts
    # Has parameters :id, :user_id, :name
    class Blog < Sequel::Model
      unrestrict_primary_key
      plugin :validation_helpers
      many_to_one :user
      one_to_many :posts

      def validate
        super
#        validates_presence %i[name user_id]
        validates_presence :name
      end
    end
  end
end
