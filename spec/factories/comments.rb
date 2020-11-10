# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: 'Byg::Models::Comment' do
    sequence :id
    user_id { create(:user).id }
    post_id { create(:post).id }
    text { 'COMMENT' }

    trait :with_reactions do
      after(:create) do |comment|
        create_list(:reaction, 1, user_id: create(:user).id,
          comment_id: comment.id, value: 1)
      end
    end
  end
end
