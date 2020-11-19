# frozen_string_literal: true

RSpec.describe Byg::Models::Post do
  it { is_expected.to respond_to(:update).with(1).argument }

  describe '.update' do
    subject(:update) { post.update(params) }

    let(:blog) { create(:blog) }
    let(:post) { create(:post, blog_id: blog.id) }

    context 'with text not present or blank' do
      let(:params) { { text: ' ' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { update }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with blog_id' do
      let(:params) { { blog_id: 100 } }

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

      it 'updates a DB[:posts] row' do
        expect(update.reload.values).to be > params
      end
    end
  end
end
