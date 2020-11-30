# frozen_string_literal: true

RSpec::Matchers.define_negated_matcher :not_change, :change

require_relative 'spec_requirements'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # FactoryBot support
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.definition_file_paths = ['/vagrant/app/spec/factories/']
    FactoryBot.find_definitions
  end

  config.before do
    FactoryBot.rewind_sequences
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.filter_run_when_matching :focus
  # config.example_status_persistence_file_path = "spec/examples.txt"
  # config.disable_monkey_patching!
  # config.warnings = true
  # if config.files_to_run.one?
  #   config.default_formatter = "doc"
  # end
  # config.profile_examples = 10
  # config.order = :random
  # Kernel.srand config.seed
end
