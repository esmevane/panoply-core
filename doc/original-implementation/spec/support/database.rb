require 'active_record'
require 'pg'

config = {
  adapter:  'postgresql',
  host:     'localhost',
  encoding: 'unicode',
  username: 'panoply',
  database: 'panoply-core-test' }

ActiveRecord::Base.establish_connection config
