require 'sequel'

MemoryStore = Sequel.sqlite

MemoryStore.create_table :accounts do
  primary_key :id
  String      :email
  String      :name
  String      :encrypted_password
  String      :salt
end

class Schema
  def tables
    [ :accounts ]
  end

  def self.clear
    new.tables.map { |table| MemoryStore[table].delete }
  end
end
