require 'active_record'
require 'squeel'
require './db/connection'

module Schema
  class MakeTables < ActiveRecord::Migration
    def change
      create_table :messages do |table|
        table.integer :sender_id
        table.text    :body
        table.integer :thread_ids, array: true

        table.timestamps
      end

      create_table :labels do |table|
        table.integer :message_id
        table.integer :account_id
        table.string  :content, array: true
        table.timestamps
      end

      create_table :accounts do |table|
        table.string :username
        table.timestamps
      end

      add_index :messages, :sender_id, using: :gin
      add_index :messages, :thread_ids, using: :gin
      add_index :labels, :message_id, using: :gin
      add_index :labels, :account_id, using: :gin
      add_index :labels, :content, using: :gin
    end
  end

  def self.load!
    Connection.establish
    MakeTables.new.change
  end
end

module Squeel
  module Nodes
    module Operators
      def within *list
        list = "{#{list.map(&:to_s).join(',')}}"
        Operation.new self, :'@>', list
      end
    end
  end
end

Connection.establish
Connection.clear!
Schema::MakeTables.new.change

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'Account', foreign_key: 'sender_id'
  has_many :labels
  has_many :accounts, through: :labels
end

class Label < ActiveRecord::Base
  belongs_to :account
  belongs_to :message

  scope :for_accounts, -> *account_ids do
    where { |query| query.recipient_ids.within *account_ids }
  end

  scope :labeled_by, -> *labels do
    where { |query| query.labels.within *labels }
  end

end

class Account < ActiveRecord::Base
  has_many :labels
  has_many :messages, through: :labels
end

ids = Label.where(account_id: [2]).where { content.within "Unread" }.
  select { message_id }

Message.where { id.in ids }