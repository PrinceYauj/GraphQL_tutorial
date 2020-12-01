# frozen_string_literal: true

require_relative 'helper'

RSpec.shared_context 'graphql' do
  include Byg::Helper

  subject(:gql_class) { described_class.new(params) }

  let(:params) { { object: nil, context: {}, field: nil } }
  let(:errors) { execute.to_h['errors'] }
  let(:execute) { Byg::Schema.execute(mutation_string) }
  let(:mutation_string) { generate_mutation(described_class, args) }
end
