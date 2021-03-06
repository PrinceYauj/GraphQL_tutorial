# frozen_string_literal: true

require 'sequel'
require 'graphql'
require 'factory_bot'
DB = Sequel.connect('postgres://rails:3@localhost:5432/testdb')
require_relative '/vagrant/app/models/models'
require_relative '/vagrant/app/spec/support/database_cleaner'
require_relative '/vagrant/app/spec/factories/sequel_support'
require_relative '/vagrant/app/graphql/types/types'
require_relative '/vagrant/app/graphql/mutations/mutations'
require_relative '/vagrant/app/graphql/schema'
require_relative '/vagrant/app/spec/graphql/shared'
