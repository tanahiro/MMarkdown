lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mmarkdown/version"

Gem::Specification.new do |spec|
  spec.name     = "mmarkdown"
  spec.version  = MMarkdown::VERSION
  spec.authors  = ["Hiroyuki Tanaka"]
  spec.email    = ["hryktnk@gmail.com"]
  spec.summary  = "Kramdown based markdown parser and HTML generator"
  spec.description = "Kramdown based markdown to HTML tool with math rendering"
  spec.homepage = "https://github.com/tanahiro/mmarkdown"
  spec.licenses = ["MIT"]

  spec.files = `git ls-files`.split("\n")
  spec.executables = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^test/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kramdown", "~> 1.0"
  spec.add_dependency "itextomml", "~> 1.0"

  spec.add_development_dependency "nokogiri", "~> 1.8"
end

