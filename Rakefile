require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = Dir.glob('spec/**/*_spec.rb')
end

task default: [ :test ]