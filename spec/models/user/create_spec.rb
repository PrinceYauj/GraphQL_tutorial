# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { expect(described_class).to respond_to(:create).with(1).argument }

  describe '.create' do
    # since FB uses #new, #= and #save it's possible to specify id
    # and this is unwanted behavior
    subject(:create_user) { described_class.create(params) }
    let!(:user) { create(:user, name: 'user_1', email: 'user_1@example.com') }

    context 'with name not unique' do
      let(:params) { { name: 'user_1' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_user }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with email not unique' do
      let(:params) { { email: 'user_1@example.com' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_user }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with name too short' do
      let(:params) { { name: 'a' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_user }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with name too long' do
      let(:params) { { name: 'a' * 101 } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_user }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with invalid email' do
      let(:params) { { email: 'invalid email' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_user }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_user }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    # TODO remove this after trigger rework 

    context 'with not numerical karma' do
      let(:params) { { karma: 'not a number', name: 'aaa', email: 'a@a.com' } }
      it 'raises Sequel::DatabaseError' do
        expect{ create_user }.to raise_error(Sequel::DatabaseError)
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'aaa', email: 'a@a.com' } }
      it 'creates a DB[:blogs] row' do
        expect{ create_user }.to change{ DB[:users].count }.by(1)
      end
    end
  end
end
