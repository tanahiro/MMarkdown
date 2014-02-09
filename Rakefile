require 'rake'
require 'rake/testtask'

require "#{__dir__}/lib/mmarkdown"

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = false
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name          = "mmarkdown"
    gem.summary       = "Markdown with MathML"
    gem.author        = "Hiroyuki Tanaka"
    gem.email         = "hryktnk@gmail.com"
    gem.version       = MMarkdown::VERSION
    gem.files         = `git ls-files`.split("\n")
    gem.test_files    = `git ls-files -- test/*`.split("\n")
    gem.licenses      = ["MIT License"]
    gem.homepage      = "http://github.com/tanahiro/mmarkdown"
    gem.add_dependency("redcarpet", "~> 3.0")
    gem.add_dependency("math_ml",   "~> 0.14")
    gem.add_development_dependency("nokogiri", "~> 1.0")
    gem.add_development_dependency("jeweler",  "~> 2.0")
    gem.description = <<-EOF
Convert Markdown to HTML with MathML
    EOF
  end
rescue LoadError
  puts "Jewelr not installed"
end

