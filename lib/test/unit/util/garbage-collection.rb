module Test
  module Unit
    module Util
      module GarbageCollection
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
        def with_gc_stress(stress=true)
          stress_keep, GC.stress = GC.stress, stress
          yield
        ensure
          GC.stress = stress_keep
        end
      end
    end
  end
end
