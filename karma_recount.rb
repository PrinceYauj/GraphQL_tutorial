#!/usr/bin/env ruby

require 'sequel'

DB = Sequel.connect('postgres://rails:3@localhost:5432/graph')
DB.run("CALL user_karma_recount();")
DB.disconnect