# frozen_string_literal: true

require_relative 'requirements'

# NODOC
class Schema < GraphQL::Schema
  query Byg::Types::QueryType
end

query_string = '{
  user(id: 1) {
    id
    name
    email
    karma
    blogs {
      name
      posts {
        text
        comments {
          text
          user {
            name
          }
          reactions {
            user {
              name
            }
            value
          }
        }
      }
    }
  }
}'

p Schema.execute(query_string)
