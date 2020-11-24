# frozen_string_literal: true

require_relative 'requirements'

create_string = 'mutation {
  createBlog(name: "!", userId: 1)
  {
    id
    name
  }
}'

p Byg::Schema.execute(create_string)

