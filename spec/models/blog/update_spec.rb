# frozen_string_literal: true

RSpec.describe Byg::Models::Blog do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { blog.update(params) }

    let(:user) { create(:user) }
    let(:blog) { create(:blog, user_id: user.id) }

    context 'with name not present or blank' do
      let(:params) { { name: ' ' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with user_id' do
      let(:params) { { user_id: 100 } }
      it 'raises Sequel::DatabaseError' do
        expect{ update }.to raise_error(Sequel::DatabaseError)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'new name' } }
      it 'updates a DB[:blogs] row' do
        expect(update.reload.values).to be > params
      end
    end
  end
end
