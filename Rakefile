require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'tests'
  t.pattern = 'tests/**/*_test.rb'
end

RuboCop::RakeTask.new

task default: %i(rubocop test)
