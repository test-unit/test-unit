# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/test/unit/version.rb'

Hoe.new('test-unit', Test::Unit::VERSION) do |p|
  p.developer('Kouhei Sutou', 'kou@cozmixng.org')
  p.developer('Ryan Davis', 'ryand-ruby@zenspider.com')

  # Ex-Parrot:
  # p.developer('Nathaniel Talbott', 'nathaniel@talbott.ws')
end

task :check_manifest => :clean_test_result

task :clean_test_result do
  test_results = Dir.glob("**/.test-result")
  sh("rm", "-rf", *test_results) unless test_results.empty?
end

# vim: syntax=Ruby
