# frozen_string_literal: true

RSpec.describe Byg::Models::Comment do
  it { expect(described_class).to respond_to(:create).with(1).argument }

  describe '.create' do
    # since FB uses #new, #= and #save it's possible to specify id
    # and this is unwanted behavior
    subject(:create_comment) { described_class.create(params) }
    let!(:user) { user_with_posts }

    context 'with text not present or blank' do
      let(:params) { { user_id: user.id, post_id: user.posts[0].id, text: '' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_comment }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with post_id not present' do
      let(:params) { { user_id: user.id, text: 'a' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_comment }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with user_id not present' do
      let(:params) { { post_id: user.posts[0].id, text: 'a' } }
      it 'raises Sequel::ValidationFailed error' do
        expect{ create_comment }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_comment }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }
      it 'raises Sequel::MassAssignmentRestriction error' do
        expect{ create_comment }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with valid params' do
      let(:params) { { user_id: user.id, post_id: user.posts[0].id,
                       text: 'valid text' } }
      it 'creates a DB[:comments] row' do
        expect{ create_comment }.to change{ DB[:comments].count }.by(1)
      end
    end
  end
end
