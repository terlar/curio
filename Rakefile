require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %w(test rubocop)
task test: 'test:all'

namespace :test do
  desc 'Run all tests'
  Rake::TestTask.new :all do |t|
    t.test_files = Rake::FileList['test/*_test.rb']
  end

  desc 'Run unit tests'
  Rake::TestTask.new :unit do |t|
    t.test_files = Rake::FileList['test/unit_test.rb']
  end

  desc 'Run integration tests'
  Rake::TestTask.new :integration do |t|
    t.test_files = Rake::FileList['test/integration_test.rb']
  end
end
