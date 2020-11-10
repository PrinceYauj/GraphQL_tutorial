# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to be_a(Sequel::Model) }

  it 'responds to methods: #id, #name, #email, #karma, #blogs, #comments' +
    ', #reactions' do
    is_expected.to respond_to(:id, :name, :email, :karma, :blogs, 
      :comments, :reactions)
  end
end
