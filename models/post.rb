# frozen_string_literal: true

require 'sequel'

module Byg
  module Models
    # post model. Belongs to the Blog. Has many comments
    # Has parameters :id, :blog_id, :text
    class Post < Sequel::Model
      plugin :validation_helpers
      many_to_one :blog
      one_to_many :comments
      one_to_many :reactions

      def validate
        super
#        validates_presence %i[text user_id]
        validates_presence :text
      end
    end
  end
end
