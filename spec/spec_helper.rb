require 'simplecov'

SimpleCov.start { add_filter '/spec/' }

require 'minitest/autorun'
require 'minitest/pride'

require './db/schema'

class MiniTest::Spec
  after(:each) { Schema.clear }
end
