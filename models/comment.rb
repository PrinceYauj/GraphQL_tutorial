# frozen_string_literal: true

module Byg
  module Models
    # comment model. Belongs to the Post. Belongs to the User. 
    # Has many reactions.
    # Has parameters :id, :post_id, user_id, :text, :karma
    # :post_id, :user_id updates are forbidden with DB trigger comment_fk
    class Comment < Sequel::Model
      plugin :validation_helpers
      many_to_one :post
      many_to_one :user
      one_to_many :reactions

      def validate
        super
        validates_presence %i[post_id user_id text]
      end
    end
  end
end
