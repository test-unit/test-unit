#--
#
# Author:: Tsutomu Katsube.
# Copyright:: Copyright (c) 2026 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

module Test
  module Unit
    class << self
      # @api private
      def ractor_available?
        # The Ractor runner needs Ruby 4.1 or later.
        defined?(Ractor) and
          Ractor.respond_to?(:shareable_lambda) and
          Ractor.method_defined?(:alive?)
      end

      # @api private
      def non_main_ractor?
        ractor_available? and not Ractor.main?
      end
    end
  end
end
