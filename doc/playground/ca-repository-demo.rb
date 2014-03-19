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

module Panoply
  module Repos
    class Accounts
      def initialize options
        @model = Model.new options
      end

      def save
        @model.save
      end
      class Model < Sequel::Model :accounts
      end
    end
  end
end