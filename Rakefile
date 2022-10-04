# -*- ruby -*-
#
# Copyright (C) 2008-2017  Kouhei Sutou <kou@clear-code.com>

Encoding.default_internal = "UTF-8" if defined?(Encoding.default_internal)

# TODO: Remove me when we drop Ruby 1.9 support.
unless "".respond_to?(:b)
  class String
    def b
      dup.force_encoding("ASCII-8BIT")
    end
  end
end

require "erb"
require "yaml"
require "rubygems"
require "rake/clean"
require "yard"
require "bundler/gem_helper"
require "packnga"

task :default => :test

base_dir = File.dirname(__FILE__)

helper = Bundler::GemHelper.new(base_dir)
def helper.version_tag
  version
end

helper.install
spec = helper.gemspec

document_task = Packnga::DocumentTask.new(spec) do |task|
  task.original_language = "en"
  task.translate_languages = ["ja"]
end

Packnga::ReleaseTask.new(spec) do |task|
  test_unit_github_io_dir_candidates = [
    "../../www/test-unit.github.io",
  ]
  test_unit_github_io_dir = test_unit_github_io_dir_candidates.find do |dir|
    File.directory?(dir)
  end
  task.index_html_dir = test_unit_github_io_dir
end

def rake(*arguments)
  ruby($0, *arguments)
end

task :test do
  ruby("test/run-test.rb")
end

namespace :doc do
  task :add_permalink do
    news_md = File.read("doc/text/news.md")
    base_url = "https://github.com/test-unit/test-unit/pull/"

    applied_typed_permalink = news_md.gsub(/(?<pre>\[GitHub#(?<ref>\d+)\])(?<post> ?\[(?<type>Report|Patch))/) do
      typed_base_url = Regexp.last_match[:type] == "Report" ? "https://github.com/test-unit/test-unit/issues/" : base_url

      "#{Regexp.last_match[:pre]}(#{typed_base_url}#{Regexp.last_match[:ref]})#{Regexp.last_match[:post]}"
    end

    applied_all_permalink = applied_typed_permalink.gsub(/(?<pre>\[GitHub#(?<ref>\d+)\])(?!\()/) do
      "#{Regexp.last_match[:pre]}(#{base_url}#{Regexp.last_match[:ref]})"
    end

    File.write("doc/text/news.md", applied_all_permalink)
  end
end
