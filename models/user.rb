# frozen_string_literal: true

module Byg
  module Models
    # user model. Has many blogs
    # Has parameters :id, :name, :email, :karma
    # :karma is set to 0 on create with DB trigger user_karma
    # :name and :email must be unique separately
    class User < Sequel::Model
      EMAIL_REGEXP = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i.freeze
      plugin :validation_helpers
      one_to_many :blogs
      one_to_many :comments
      one_to_many :reactions

      def validate
        super
        validates_length_range (3..100), :name
        validates_format EMAIL_REGEXP, :email
        val_case_insensitive_uniq(:name)
        val_case_insensitive_uniq(:email)
      end

      def val_case_insensitive_uniq(param)
        validates_unique param, where: (lambda do |ds, obj, cols|
          ds.where(cols.map do |c|
            v = obj.public_send(c)
            v = v.downcase if v
            [Sequel.function(:lower, c), v]
          end)
        end)
      end

      def posts
        blogs.map(&:posts).flatten
      end
    end
  end
end
