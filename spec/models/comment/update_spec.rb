# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { comment.update(params) }

    let(:user) { user_with_posts }
    let(:comment) { create(:comment, user_id: user.id,
                                     post_id: user.posts[0].id) }

    context 'with text not present or blank' do
      let(:params) { { text: ' ' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with invalid post_id' do
      let(:params) { { post_id: -1 } }
      it 'raises Sequel::ForeignKeyConstraintViolation error' do
        expect{ update }.to raise_error(Sequel::ForeignKeyConstraintViolation)
      end
    end

    context 'with invalid user_id' do
      let(:params) { { user_id: -1 } }
      it 'raises Sequel::ForeignKeyConstraintViolation error' do
        expect{ update }.to raise_error(Sequel::ForeignKeyConstraintViolation)
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

    #TODO forbid user_id and post_id updates

    context 'with valid params' do
      let(:user2) { user_with_posts }
      let(:params) { { text: 'new text', user_id: user2.id,
                       post_id: user2.posts[0].id } }
      it 'updates a DB[:comments] row' do
        expect(update.reload.values).to be > params
      end
    end
  end
end
