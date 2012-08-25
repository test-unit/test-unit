module Test
  module Unit
    module ExceptionHandler
      @@exception_handlers = []
      class << self
        def exception_handlers
          @@exception_handlers
	end

        def included(base)
          base.extend(ClassMethods)

          observer = Proc.new do |test_case, _, _, value, method_name|
            if value
              @@exception_handlers.unshift(method_name)
            else
              @@exception_handlers -= [method_name]
            end
          end
          base.register_attribute_observer(:exception_handler, &observer)
        end
      end

      module ClassMethods
        def exception_handlers
          ExceptionHandler.exception_handlers
        end

        # @overload exception_handler(method_name)
        #   Add an exception handler method.
        #
        #   @param method_name [Symbol]
        #      The method name that handles exception raised in tests.
        #   @return [void]
        #
        # This is a public API for developers who extend test-unit.
        def exception_handler(*method_names)
          attribute(:exception_handler, true, *method_names)
        end

        def unregister_exception_handler(*method_names)
          attribute(:exception_handler, false, *method_names)
        end
      end
    end
  end
end
