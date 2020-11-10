# frozen_string_literal: true

module Byg
  module Models
    # post model. Belongs to the Blog. Has many comments
    # Has parameters :id, :blog_id, :text
    class Post < Sequel::Model
      plugin :validation_helpers
      many_to_one :blog
      one_to_many :comments

      def validate
        super
        validates_presence %i[text blog_id]
      end
    end
  end
end
