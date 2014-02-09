require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |task|
  %w(spec lib).each { |source| task.libs << source }
  task.pattern = "spec/**/*_spec.rb"
end

task default: [ :test ]
