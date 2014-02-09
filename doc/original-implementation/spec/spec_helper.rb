require 'simplecov'

SimpleCov.start { add_filter '/spec/' }

require 'minitest/autorun'
require 'minitest/pride'

require 'support/database'

require_relative '../lib/panoply'

require 'fabrication'
require 'database_cleaner'
require "fabrications/data"

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before(:each) { DatabaseCleaner.start }
  after(:each) { DatabaseCleaner.clean }
end
