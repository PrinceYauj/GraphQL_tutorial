# frozen_string_literal: true

RSpec.describe Byg::Models::Post do
  it { expect(described_class).to respond_to(:create).with(1).argument }

  describe '.create' do
    # since FB uses #new, #= and #save it's possible to specify id
    # and this is unwanted behavior
    subject(:create_post) { described_class.create(params) }

    let(:blog) { create(:blog) }

    context 'with text not present or blank' do
      let(:params) { { blog_id: blog.id, text: ' ' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { create_post }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with blog_id not present' do
      let(:params) { { text: 'a' } }

      it 'raises Sequel::ValidationFailed error' do
        expect { create_post }.to raise_error(Sequel::ValidationFailed)
      end
    end

    context 'with id in params' do
      let(:params) { { id: -1 } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { create_post }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with invalid param' do
      let(:params) { { invalid_param: 1 } }

      it 'raises Sequel::MassAssignmentRestriction error' do
        expect { create_post }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'with valid params' do
      let(:params) { { blog_id: blog.id, text: 'valid text' } }

      it 'creates a DB[:posts] row' do
        expect { create_post }.to change { DB[:posts].count }.by(1)
      end
    end
  end
end
