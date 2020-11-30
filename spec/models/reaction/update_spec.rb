# frozen_string_literal: true

RSpec.describe Byg::Models::Reaction do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { reaction.update(params) }

    let(:user) { user_with_comments }
    let(:comment) { user.comments[0] }
    let(:reaction) do
      create(:reaction, user_id: user.id, comment_id: comment.id)
    end

    context 'with nil value' do
      let(:params) { { value: nil } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with numeric value different from 0, -1, 1' do
      let(:params) { { value: 9001 } }

      it 'raises Sequel::CheckConstraintViolation error' do
        expect { update }.to raise_error(Sequel::CheckConstraintViolation)
      end
    end

    context 'with not numeric value' do
      let(:params) { { value: 'a' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with comment_id' do
      let(:params) { { comment_id: -1 } }

      it 'raises Sequel::DatabaseError' do
        expect { update }.to raise_error(Sequel::DatabaseError)
      end
    end

    context 'with user_id' do
      let(:params) { { user_id: -1 } }

      it 'raises Sequel::DatabaseError' do
        expect { update }.to raise_error(Sequel::DatabaseError)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { update }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with valid params' do
      let(:params) { { value: 0 } }

      it 'updates a DB[:comments] row' do
        expect(update.reload.values).to be > params
      end
    end
  end
end
