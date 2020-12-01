# frozen_string_literal: true

module Byg
  # NODOC
  class Schema < GraphQL::Schema
    query Byg::Types::QueryType
    mutation Byg::Types::MutationType
    use GraphQL::Execution::Errors
    rescue_from(StandardError) do |e|
      raise GraphQL::ExecutionError, e.to_s
    end
  end
end
