# frozen_string_literal: true

module Byg
  module Types
    # NODOC
    class MutationType < GraphQL::Schema::Object
      require_relative '../mutations/mutations'
      field :create_user,     mutation: Byg::Mutations::CreateUser
      field :create_blog,     mutation: Byg::Mutations::CreateBlog
      field :create_post,     mutation: Byg::Mutations::CreatePost
      field :create_comment,  mutation: Byg::Mutations::CreateComment
      field :create_reaction, mutation: Byg::Mutations::CreateReaction

      field :update_user,     mutation: Byg::Mutations::UpdateUser
      field :update_blog,     mutation: Byg::Mutations::UpdateBlog
      field :update_post,     mutation: Byg::Mutations::UpdatePost
      field :update_comment,  mutation: Byg::Mutations::UpdateComment
      field :update_reaction, mutation: Byg::Mutations::UpdateReaction

      field :destroy_user,     mutation: Byg::Mutations::DestroyUser
      field :destroy_blog,     mutation: Byg::Mutations::DestroyBlog
      field :destroy_post,     mutation: Byg::Mutations::DestroyPost
      field :destroy_comment,  mutation: Byg::Mutations::DestroyComment
      field :destroy_reaction, mutation: Byg::Mutations::DestroyReaction
    end
  end
end
