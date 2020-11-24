# frozen_string_literal: true

require 'sequel'
require 'graphql'
Sequel::Model.plugin :json_serializer

DB = Sequel.connect('postgres://rails:3@localhost:5432/graph')

require_relative 'models/models'
require_relative 'graphql/types/types'
require_relative 'graphql/mutations/mutations'
require_relative 'graphql/schema'
