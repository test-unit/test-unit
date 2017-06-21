require 'test/unit/ui/console/testrunner'

module Test
  module Unit
    module UI
      module Emacs
        class TestRunner < Console::TestRunner
          private
          def output_setup_end
          end

          def output_started
          end

          def format_fault(fault)
            return super unless fault.respond_to?(:label)
            format_method_name = "format_fault_#{fault.label.downcase}"
            if respond_to?(format_method_name, true)
              __send__(format_method_name, fault)
            else
              super
            end
          end

          def format_fault_failure(failure)
            if failure.location.size == 1
              location = failure.location[0]
              location_display = location.sub(/\A(.+:\d+).*/, ' [\\1]')
            else
              location_display = "\n" + failure.location.join("\n")
            end
            "#{failure.label}:\n" \
            "#{failure.test_name}#{location_display}:\n#{failure.message}"
          end

          def format_fault_error(error)
            "#{error.label}:\n" \
            "#{error.test_name}:\n" \
            "#{error.message}\n#{error.backtrace.join("\n")}"
          end
        end
      end
    end
  end
end
