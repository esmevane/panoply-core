module Panoply
  module Data
    class Account < ActiveRecord::Base
      has_many :labels
      has_many :messages, through: :labels
    end
  end
end
