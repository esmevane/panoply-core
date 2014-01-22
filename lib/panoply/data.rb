require 'active_record'
require './lib/support/squeel'

module Panoply
  module Data
    autoload :Account, 'panoply/data/account'
    autoload :Label,   'panoply/data/label'
    autoload :Message, 'panoply/data/message'
  end
end