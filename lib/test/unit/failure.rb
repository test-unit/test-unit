#--
#
# Author:: Nathaniel Talbott.
# Copyright:: Copyright (c) 2000-2002 Nathaniel Talbott. All rights reserved.
# License:: Ruby license.

module Test
  module Unit

    # Encapsulates a test failure. Created by Test::Unit::TestCase
    # when an assertion fails.
    class Failure
      attr_reader :test_name, :location, :message
      
      SINGLE_CHARACTER = 'F'
      LABEL = "Failure"

      # Creates a new Failure with the given location and
      # message.
      def initialize(test_name, location, message)
        @test_name = test_name
        @location = location
        @message = message
      end
      
      # Returns a single character representation of a failure.
      def single_character_display
        SINGLE_CHARACTER
      end

      def label
        LABEL
      end

      # Returns a brief version of the error description.
      def short_display
        "#@test_name: #{@message.split("\n")[0]}"
      end

      # Returns a verbose version of the error description.
      def long_display
        location_display = if(location.size == 1)
          location[0].sub(/\A(.+:\d+).*/, ' [\\1]')
        else
          "\n    [#{location.join("\n     ")}]"
        end
        "#{label}:\n#@test_name#{location_display}:\n#@message"
      end

      # Overridden to return long_display.
      def to_s
        long_display
      end
    end

    module FailureHandler
      class << self
        def included(base)
          base.exception_handler(:handle_assertion_failed_error)
        end
      end

      private
      def handle_assertion_failed_error(exception)
        return false unless exception.is_a?(AssertionFailedError)
        problem_occurred
        failure = Failure.new(name,
                              filter_backtrace(exception.backtrace),
                              exception.message)
        current_result.add_failure(failure)
        true
      end
    end
  end
end
