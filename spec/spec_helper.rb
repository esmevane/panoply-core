require 'simplecov'

SimpleCov.start { add_filter '/spec/' }

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/panoply'
