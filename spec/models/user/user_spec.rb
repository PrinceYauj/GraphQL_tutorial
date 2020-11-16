# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to be_a(Sequel::Model) }

  it { is_expected.to respond_to(:id, :name, :email, :karma) }
  it { is_expected.to respond_to(:blogs, :comments, :reactions) }
end
