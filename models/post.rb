# frozen_string_literal: true

module Byg
  module Models
    # post model. Belongs to the Blog. Has many comments
    # Has parameters :id, :blog_id, :text
    # :blog_id updates are forbidden with DB trigger post_fk
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
