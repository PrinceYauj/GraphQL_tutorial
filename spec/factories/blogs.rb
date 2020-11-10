# frozen_string_literal: true

FactoryBot.define do
  factory :blog, class: 'Byg::Models::Blog' do
    sequence :id
    user_id { create(:user).id }
    name { 'b' }

    trait :with_posts do
      after(:create) do |blog|
        create_list(:post, 2, blog_id: blog.id)
      end
    end
  end
end
