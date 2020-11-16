# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { is_expected.to be_a(Sequel::Model) }
  it { is_expected.to respond_to(:id, :name, :user, :posts) }
end
