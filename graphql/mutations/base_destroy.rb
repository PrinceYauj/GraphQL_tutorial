# frozen_string_literal: true

module Byg
  module Mutations
    # NODOC
    class BaseDestroy < GraphQL::Schema::Mutation
      argument :id, Integer, required: true

      def self.inherited(subclass)
        caller_model = get_model(subclass)
        subclass.type Byg::Types.const_get(caller_model)
      end

      def resolve(id:)
        model = self.class.get_model(self.class)
        Byg::Models.const_get(model).with_pk!(id).destroy
      end

      def self.get_model(klass)
        klass.name.sub('Byg::Mutations::Destroy', '')
      end
    end
  end
end
