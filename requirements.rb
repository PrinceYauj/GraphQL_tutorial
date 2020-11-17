require 'sequel'
require 'graphql'
Sequel::Model.plugin :json_serializer

DB = Sequel.connect('postgres://rails:3@localhost:5432/graph')

require_relative 'models/models.rb'
require_relative 'graphql/types/types.rb'