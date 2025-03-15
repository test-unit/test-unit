# -*- mode: ruby; coding: utf-8 -*-

source "https://rubygems.org"

gemspec

group :test do
  gem("bigdecimal")
  gem("csv") if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.3.0")
end

group :development do
  gem("bundler")
  gem("rake")
  gem("yard")
  gem("kramdown")
  gem("packnga")
end
