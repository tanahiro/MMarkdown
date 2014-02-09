require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'

require "#{__dir__}/lib/mmarkdown"

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = false
end

spec = Gem::Specification.new do |s|
  s.summary       = "Markdown with MathML"
  s.name          = "mmarkdown"
  s.author        = "Hiroyuki Tanaka"
  s.email         = "hryktnk@gmail.com"
  s.version       = MMarkdown::VERSION
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.licenses      = ["Ruby License"]
  s.require_paths = "lib"
  s.add_dependency("redcarpet", "~> 3.0")
  s.add_dependency("math_ml",   "~> 0.14")
  s.add_development_dependency("nokogiri", "~> 1.0")
  s.description = <<-EOF
Convert Markdown to HTML with MathML
  EOF
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

