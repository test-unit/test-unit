# -*- mode: ruby; coding: utf-8 -*-

clean_white_space = lambda do |entry|
  entry.gsub(/(\A\n+|\n+\z)/, '') + "\n"
end

require "./lib/test/unit/version"

version = Test::Unit::VERSION.dup

Gem::Specification.new do |spec|
  spec.name = "test-unit"
  spec.version = version
  spec.rubyforge_project = "test-unit"
  spec.homepage = "http://test-unit.rubyforge.org/"
  spec.authors = ["Kouhei Sutou", "Haruka Yoshihara"]
  spec.email = ["kou@cozmixng.org", "yoshihara@clear-code.com"]
  readme = File.read("README.textile")
  readme.force_encoding("UTF-8") if readme.respond_to?(:force_encoding)
  entries = readme.split(/^h2\.\s(.*)$/)
  description = clean_white_space.call(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.license = "Ruby's and PSFL (lib/test/unit/diff.rb)"
  spec.files = ["README.textile", "TODO", "Rakefile", "COPYING", "GPL", "PSFL"]
  spec.files += Dir.glob("{lib,sample}/**/*.rb")
  spec.test_files += Dir.glob("test/**/*")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("yard")
end
