# frozen_string_literal: true

module Byg
  # NODOC
  class Schema < GraphQL::Schema
    query Byg::Types::QueryType
    mutation Byg::Types::MutationType
    use GraphQL::Execution::Errors
    rescue_from(StandardError){|e| p e.inspect}
  end
end

