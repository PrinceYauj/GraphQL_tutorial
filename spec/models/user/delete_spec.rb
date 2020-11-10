# frozen_string_literal: true

RSpec.describe Byg::Models::User do
  it { is_expected.to respond_to(:destroy).with(0).arguments }

  describe '.destroy' do
    subject(:destroy) { user.destroy }

    before do
      FactoryBot.rewind_sequences
    end

    context 'when user has blogs' do
      let!(:user) { user_with_blogs(2) }

      it 'destroys the user instance' do
        expect{ destroy }.to change{ described_class[user.id] }.to(nil)
      end

      it 'destroys user\'s blogs' do
        expect{ destroy }.to change{ DB[:blogs].count }.from(2).to(0)
      end
    end

    context 'when user has comments' do
      let!(:user) { user_with_comments(2) }

      it 'destroys the user instance' do
        expect{ destroy }.to change{ described_class[user.id] }.to(nil)
      end

      it 'destroys user\'s comments' do
        expect{ destroy }.to change{ DB[:comments].count }.from(2).to(0)
      end
    end

    context 'when user has reactions' do
      let!(:user) { user_with_reactions(3) }

      it 'destroys the user instance' do
        expect{ destroy }.to change{ described_class[user.id] }.to(nil)
      end

      it 'destroys user\'s reactions' do
        expect{ destroy }.to change{ DB[:reactions].count }.from(3).to(0)
      end
    end
  end
end

