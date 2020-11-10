# frozen_string_literal: true

FactoryBot.define do
  factory :reaction, class: 'Byg::Models::Reaction' do
    sequence :id
    user_id { create(:user).id }
    comment_id { create(:comment).id }
    value { -1 }
  end
end
