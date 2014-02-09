require 'active_record'
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
        table.string  :content, array: true, null: false, default: '{}'
        table.timestamps
      end

      create_table :accounts do |table|
        table.string :username
        table.timestamps
      end

      add_index :messages, :sender_id
      add_index :messages, :thread_ids, using: :gin
      add_index :labels, :message_id
      add_index :labels, :account_id
      add_index :labels, :content, using: :gin
    end
  end

  def self.load!
    Connection.establish
    MakeTables.new.change
  end
end
