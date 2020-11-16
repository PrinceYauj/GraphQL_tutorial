# frozen_string_literal: true

RSpec.describe Byg::Models::Reaction do
  it { expect(described_class).to respond_to(:create).with(1).argument }

  describe '.create' do
    # since FB uses #new, #= and #save it's possible to specify id
    # and this is unwanted behavior
    subject(:create_reaction) { described_class.create(params) }
    let(:user) { user_with_comments }
    let(:comment) { user.comments[0] }

    context 'with comment_id not present' do
      let(:params) { { user_id: user.id, value: 1 } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_reaction }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with user_id not present' do
      let(:params) { { comment_id: comment.id, value: 1 } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_reaction }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_reaction }.to\
          raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_reaction }.to\
          raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with user_id and comment_id pair not unique' do
      let(:params) { { user_id: user.id, comment_id: comment.id, value: 1 } }
      let!(:reaction) { create(:reaction, params) }
      it 'raises Sequel::ValidationFailed error' do 
        expect{ create_reaction }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with valid params' do
      let(:params) { { user_id: user.id, comment_id: comment.id, value: 1 } }
      it 'creates a DB[:reactions] row' do
        expect{ create_reaction }.to change{ DB[:reactions].count }.by(1)
      end
    end

    context 'without a value' do
      let(:params) { { user_id: user.id, comment_id: comment.id } }
      it 'raises Sequel::ValidationFailed' do
        expect{ create_reaction }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with value is a number different from 0, 1, -1' do
      let(:params) { { user_id: user.id, comment_id: comment.id, value: 9001 } }
      it 'raises Sequel::CheckConstraintViolation error' do
        expect{ create_reaction }.to\
          raise_error(Sequel::CheckConstraintViolation)
      end
    end

    context 'with value is not numeric' do
      let(:params) { { user_id: user.id, comment_id: comment.id, value: 'a' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_reaction }.to raise_error(Sequel::ValidationFailed)
      end
    end
  end
end
