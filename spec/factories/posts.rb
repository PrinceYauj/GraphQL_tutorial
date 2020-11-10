# frozen_string_literal: true

FactoryBot.define do
  factory :post, class: 'Byg::Models::Post' do
    sequence :id
    blog_id { create(:blog).id }
    text { 'post' }

    trait :with_comments do
      after(:create) do |post|
        create_list(:comment, 2, post_id: post.id)
      end
    end
  end
end
