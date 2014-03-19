module Cask
  class Manifest

    class NilEntity
      def respond_to? method
        true
      end
      def method_missing method, *arguments, &block
        ''
      end
    end

    class Item
      attr_reader :id
      def initialize id: nil
        @id = id
      end
      def from repository
        @repository = repository
      end
      alias :repo :from
      def to entity, null: NilEntity
        @entity = entity
        @null = null
      end
      alias :entity :to
      def with collection
        @collection = collection
      end
      alias :query :with
      def to_model_params
        { map: @collection, to: @entity, from: @repository,
          null: @null }
      end
    end

    class Registry
      attr_reader :contents
      def initialize
        @contents = []
      end
      def set id, &block
        item = Item.new id: id
        item.instance_eval &block
        contents << item
      end
      alias :model :set
      def find manifest_entry_id
        contents.find { |item| item.id == manifest_entry_id }
      end
    end

    def self.find manifest_entry_id
      @registry.find manifest_entry_id
    end

    def self.register &block
      @registry = Registry.new
      @registry.instance_eval &block
      @registry
    end

  end

  class Model
    attr_reader :collection
    def initialize map: nil, to: nil, from: nil, null: nil
      @collection = map.new entity: to, repo: from
    end

    def where *arguments, &block
      @collection.where *arguments, &block
    end

    def self.for manifest_entry_id
      item = Cask::Manifest.find manifest_entry_id
      new item.to_model_params
    end
  end
end

# Cask::Manifest.register do
#   set :products do
#     from CentralStore
#     to   ProductSummary, null: NoProductSummary
#     with Products
#   end
#
#   model :product_summaries do
#     repo   CentralStore
#     entity ProductSummary, null: NoProductSummary
#     query  Products
#   end
# end
#
require 'sequel'

CentralStore = Sequel.sqlite

CentralStore.create_table :accounts do
  primary_key :id
  String      :email
  String      :name
  String      :password
  DateTime    :created_at
  DateTime    :updated_at
end

class Accounts
  attr_reader :entity, :records
  def initialize options = Hash.new
    repo     = options.fetch :repo
    @records = repo[:accounts]
    @entity  = options.fetch :entity
  end
  def build
    entity.new
  end
  def insert record
    repo.insert record
  end
  def update record
    repo.where(id: record[:id]).update record
  end
  def all
    entity.wrap records
  end
end

class AccountSummary
  attr_accessor :email, :id, :name
  def initialize options = Hash.new
    @id = options.fetch :id
    @email = options.fetch :email
    @name = options.fetch :name
  end
  def self.wrap records
    records.map { |record| new record }
  end
  def to_record
    { id: id, email: email, name: name }
  end
end

Cask::Manifest.register do
  model :account_summaries do
    repo   CentralStore
    entity AccountSummary
    query  Accounts
  end
end
