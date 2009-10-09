#--
#
# Author:: Nathaniel Talbott.
# Copyright:: Copyright (c) 2000-2002 Nathaniel Talbott. All rights reserved.
# License:: Ruby license.

module Test
  module Unit

    # Thrown by Test::Unit::Assertions when an assertion fails.
    class AssertionFailedError < StandardError
      attr_accessor :expected, :actual, :user_message
      def initialize(message=nil, options=nil)
        options ||= {}
        @expected = options[:expected]
        @actual = options[:actual]
        @user_message = options[:user_message]
        super(message)
      end
    end
  end
end
