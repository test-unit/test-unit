# -*- mode: ruby; coding: utf-8 -*-

source "https://rubygems.org"

gemspec

group :test do
  gem "bigdecimal", platforms: [:mri]
  gem "csv" if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.4.0")
end
