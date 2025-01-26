#--
#
# Author:: Tsutomu Katsube.
# Copyright:: Copyright (c) 2025 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

require_relative "test-run-context"

module Test
  module Unit
    class TestThreadRunContext < TestRunContext
      attr_reader :queue, :shutdowns
      def initialize(runner_class, queue, shutdowns)
        super(runner_class)
        @queue = queue
        @shutdowns = shutdowns
      end
    end
  end
end
