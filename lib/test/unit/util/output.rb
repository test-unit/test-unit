require "monitor"

module Test
  module Unit
    module Util
      module Output
        ##
        # Returns output for standard output and standard
        # error as string.
        #
        # Calls from multiple threads are serialized. Note that
        # output written by other threads while the block is
        # running is also captured. Don't call #capture_output in
        # another thread or fiber while the block is running. It
        # blocks or raises ThreadError.
        #
        # Example:
        #
        #     capture_output do
        #       puts("stdout")
        #       warn("stderr")
        #     end # -> ["stdout\n", "stderr\n"]
        def capture_output
          require "stringio"

          capture_output_monitor.synchronize do
            output = StringIO.new
            error = StringIO.new
            stdout_save, stderr_save = $stdout, $stderr
            $stdout, $stderr = output, error
            begin
              yield
              [output.string, error.string]
            ensure
              $stdout, $stderr = stdout_save, stderr_save
            end
          end
        end

        private
        # Monitor, not Mutex, to allow nested #capture_output. A
        # monitor per Ractor because $stdout/$stderr are Ractor
        # local.
        if defined?(Ractor.store_if_absent)
          def capture_output_monitor
            Ractor.store_if_absent(:test_unit_capture_output_monitor) do
              Monitor.new
            end
          end
        else
          CAPTURE_MONITOR = Monitor.new # :nodoc:
          def capture_output_monitor
            CAPTURE_MONITOR
          end
        end
      end
    end
  end
end
