# -*- mode: ruby; coding: utf-8 -*-
#
# Copyright (C) 2012-2013  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

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
  spec.homepage = "http://rubygems.org/gems/test-unit"
  spec.authors = ["Kouhei Sutou", "Haruka Yoshihara"]
  spec.email = ["kou@cozmixng.org", "yoshihara@clear-code.com"]
  readme = File.read("README.md")
  readme.force_encoding("UTF-8") if readme.respond_to?(:force_encoding)
  entries = readme.split(/^\#\#\s(.*)$/)
  description = clean_white_space.call(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.licenses = ["Ruby", "PSFL"] # lib/test/unit/diff.rb is PSFL
  spec.files = ["README.md", "TODO", "Rakefile"]
  spec.files += ["COPYING", "GPL", "LGPL", "PSFL"]
  spec.files += Dir.glob("{lib,sample}/**/*.rb")
  spec.files += Dir.glob("doc/text/**/*.*")
  spec.test_files += Dir.glob("test/**/*")

  spec.add_runtime_dependency("power_assert")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("yard")
  spec.add_development_dependency("kramdown")
  spec.add_development_dependency("packnga")
end
