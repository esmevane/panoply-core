require 'bundler/gem_tasks'
require 'rake/testtask'
require './db/connection'
require './db/schema'

Rake::TestTask.new do |task|
  %w(spec lib).each { |source| task.libs << source }
  task.pattern = "spec/**/*_spec.rb"
end

namespace :db do
  namespace :test do

    desc 'Recreate the database from scratch'
    task recreate: [ :create, :schema ]

    desc 'Load the schema file'
    task(:schema) { Schema.load! }

    desc 'Wipe test database and create a new one'
    task(:create) { Connection.create! }

  end
end

task default: [ :test ]
