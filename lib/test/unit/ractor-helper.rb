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

      # @api private
      def shareable_lambda(&block)
        if ractor_available?
          Ractor.shareable_lambda(&block)
        else
          block
        end
      end

      # @api private
      def shareable_lambda_if_possible(&block)
        if ractor_available?
          begin
            Ractor.shareable_lambda(&block)
          rescue Ractor::IsolationError
            block
          end
        else
          block
        end
      end
    end
  end
end
