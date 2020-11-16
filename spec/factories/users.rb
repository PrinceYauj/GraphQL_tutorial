# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'Byg::Models::User' do
    sequence :id
    sequence (:name)  { |n| "user#{n}" }
    sequence (:email) { |n| "user#{n}@example.com" }
    karma { 10 }
  end
end

def user_with_blogs(blogs_count = 1)
  user = FactoryBot.create(:user)
  FactoryBot.create_list(:blog, blogs_count, user_id: user.id)
  user
end

def user_with_posts(posts_count = 1, blogs_count = 1)
  user = user_with_blogs(blogs_count)
  blogs = user.blogs
  FactoryBot.create_list(:post, posts_count, blog_id: blogs[0].id)
  user
end

def user_with_comments(comments_count = 1, posts_count = 1, blogs_count = 1)
  user = user_with_posts(posts_count, blogs_count)
  posts = user.posts
  FactoryBot.create_list(:comment, comments_count, user_id: user.id,
    post_id: posts[0].id)
  user
end

def user_with_reactions(reactions_count = 1, comments_count = reactions_count,
                        posts_count = 1, blogs_count = 1)
  user = user_with_comments(comments_count, posts_count, blogs_count)
  comments = user.comments
  comments.each do |comment|
    FactoryBot.create(:reaction, user_id: user.id, comment_id: comment.id)
  end
  user
end
