module Test
  module Unit
    module Util
      module Output
        ##
        # Returns output for standard output and standard
        # error as string.
        #
        # Example:
        #
        #     capture_output do
        #       puts("stdout")
        #       warn("stderr")
        #     end # -> ["stdout\n", "stderr\n"]
        def capture_output
          require 'stringio'

          output = StringIO.new
          error = StringIO.new
          if Test::Unit.box_available?
            # This is required because puts()/warn() uses the ractor local variable $stdout/$stderr.
            # Those can be assigned only in the root box (at least, in Ruby 4.0.6).
            stdout_save = Ruby::Box.root.eval("$stdout")
            stderr_save = Ruby::Box.root.eval("$stderr")
            Thread.current[:stdouterr_pass] = [output, error]
            Ruby::Box.root.eval("$stdout, $stderr = Thread.current[:stdouterr_pass]")
            begin
              yield
              [output.string, error.string]
            ensure
              Thread.current[:stdouterr_pass] = [stdout_save, stderr_save]
              Ruby::Box.root.eval("$stdout, $stderr = Thread.current[:stdouterr_pass]")
            end
          else
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
      end
    end
  end
end
