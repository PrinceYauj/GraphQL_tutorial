# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { expect(described_class).to respond_to(:create).with(1).argument }

  describe '.create' do
    # since FB uses #new, #= and #save it's possible to specify id
    # and this is unwanted behavior
    subject(:create_blog) { described_class.create(params) }

    context 'with name not present or blank' do
      let(:user) { create(:user) }
      let(:params) { { user_id: user.id, name: ' ' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_blog }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with user_id not present' do
      let(:params) { { name: 'a' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_blog }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_blog }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_blog }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with valid params' do
      let(:user) { create(:user) }
      let(:params) { {user_id: user.id, name: 'valid name'} }
      it 'creates a DB[:blogs] row' do
        expect{ create_blog }.to change{ DB[:blogs].count }.by(1)
      end
    end
  end
end
