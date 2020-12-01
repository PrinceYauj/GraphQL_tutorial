#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sequel'

DB = Sequel.connect('postgres://rails:3@localhost:5432/graph')
DB.run('CALL user_karma_recount();')
DB.disconnect
