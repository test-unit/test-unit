# -*- mode: ruby; coding: utf-8 -*-
#
# Copyright (C) 2012-2013  Kouhei Sutou <kou@clear-code.com>

clean_white_space = lambda do |entry|
  entry.gsub(/(\A\n+|\n+\z)/, '') + "\n"
end

base_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(base_dir, "lib"))
require "test/unit/version"

version = Test::Unit::VERSION.dup

Gem::Specification.new do |spec|
  spec.name = "test-unit"
  spec.version = version
  spec.homepage = "http://test-unit.github.io/"
  spec.authors = ["Kouhei Sutou", "Haruka Yoshihara"]
  spec.email = ["kou@cozmixng.org", "yoshihara@clear-code.com"]
  readme = File.read("README.md")
  readme.force_encoding("UTF-8") if readme.respond_to?(:force_encoding)
  entries = readme.split(/^\#\#\s(.*)$/)
  description = clean_white_space.call(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.licenses = ["Ruby", "BSDL", "PSFL"] # lib/test/unit/diff.rb is PSFL
  spec.files = ["README.md", "Rakefile"]
  spec.files += ["COPYING", "BSDL", "PSFL"]
  spec.files += Dir.glob("{lib,sample}/**/*.rb")
  spec.files += Dir.glob("doc/text/**/*.*")
  spec.test_files += Dir.glob("test/**/*")

  spec.metadata = {
    "source_code_uri" => "https://github.com/test-unit/test-unit"
  }

  spec.add_runtime_dependency("power_assert")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("yard")
  spec.add_development_dependency("kramdown")
  spec.add_development_dependency("packnga")
end
