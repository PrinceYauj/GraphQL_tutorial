# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { user2.update(params) }

    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    before do
      FactoryBot.rewind_sequences
    end

    context 'with name not unique' do
      let(:params) { { name: user1.name } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with name too short' do
      let(:params) { { name: 'a' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with name too long' do
      let(:params) { { name: 'a' * 101 } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with email not unique' do
      let(:params) { { email: user1.email } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with invalid email' do
      let(:params) { { email: 'invalid email' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with not numerical karma' do
      let(:params) { { karma: 'not a number' } }

      it 'raises Sequel::DatabaseError' do
        expect { update }.to raise_error(Sequel::DatabaseError)
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'aaa', email: 'aaa@aaa.com', karma: 0 } }

      it 'updates a DB[:users] row' do
        expect(update.reload.values).to be > params
      end
    end

    context 'with non-existent param' do
      let(:params) { { non_existed_param: 'something' } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end
  end
end
