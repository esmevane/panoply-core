require 'active_record'
require 'pg'

module Connection
  CONFIG = {
    adapter:  'postgresql',
    host:     'localhost',
    encoding: 'unicode',
    username: 'panoply',
    database: 'panoply-core-test' }

  ROOT = CONFIG.merge database: 'postgres', schema_search_path: 'public'

  def self.establish
    ActiveRecord::Base.establish_connection CONFIG
  end

  def self.create!
    ActiveRecord::Base.establish_connection       ROOT
    ActiveRecord::Base.connection.drop_database   CONFIG[:database] rescue nil
    ActiveRecord::Base.connection.create_database CONFIG[:database]
  end
end