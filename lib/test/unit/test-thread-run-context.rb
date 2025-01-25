#--
#
# Author:: Tsutomu Katsube.
# Copyright:: Copyright (c) 2025 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

require_relative "test-run-context"

module Test
  module Unit
    class TestThreadRunContext < TestRunContext
      attr_reader :queue
      def initialize(runner_class, queue)
        super(runner_class)
        @queue = queue
      end
    end
  end
end
