require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

require "#{__dir__}/lib/mmarkdown"

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = false
end

