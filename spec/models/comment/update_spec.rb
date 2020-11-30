# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { comment.update(params) }

    let(:user) { user_with_posts }
    let(:comment) do
      create(:comment, user_id: user.id, post_id: user.posts[0].id)
    end

    context 'with text not present or blank' do
      let(:params) { { text: ' ' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with post_id' do
      let(:params) { { post_id: -1 } }

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
      let(:params) { { text: 'new text' } }

      it 'updates a DB[:comments] row' do
        expect(update.reload.values).to be > params
      end
    end
  end
end
