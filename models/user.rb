# frozen_string_literal: true

require 'sequel'

module Byg
  module Models
    # user model. Has many blogs
    # Has parameters :id, :name, :email, :karma
    class User < Sequel::Model
      EMAIL_REGEXP = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
      unrestrict_primary_key
      plugin :validation_helpers
      one_to_many :blogs
      one_to_many :comments
      one_to_many :reactions

      def validate                           # TODO refactor lambda
        super
        validates_length_range (3..100), :name
        validates_unique :name, where:(lambda do |ds, obj, cols|
          ds.where(cols.map do |c|
            v = obj.public_send(c)
            v = v.downcase if v
            [Sequel.function(:lower, c), v]
          end)
        end)
        validates_format EMAIL_REGEXP, :email
        validates_unique :email, where:(lambda do |ds, obj, cols|
          ds.where(cols.map do |c|
            v = obj.public_send(c)
            v = v.downcase if v
            [Sequel.function(:lower, c), v]
          end)
        end)
      end

      def before_update
        p self
        super
      end

    end
  end
end
