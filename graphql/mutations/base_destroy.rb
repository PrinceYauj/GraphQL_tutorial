# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class BaseDestroy < GraphQL::Schema::Resolver

      argument :id, ID, required: true

      def self.inherited(subclass)
        caller_model = get_model(subclass)
        subclass.type Byg::Types::Post, null: true
      end

      def resolve(id:)
        model = self.class.get_model(self.class)
        Byg::Models.const_get(model)[id]&.destroy
      end

      private

      def self.get_model(klass)
        klass.name.sub('Byg::Mutations::Destroy', '')
      end
    end
  end
end
