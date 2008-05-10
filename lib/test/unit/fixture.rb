module Test
  module Unit
    module Fixture
      class << self
        def included(base)
          observe_setup = Proc.new do |test_case, _, _, value, method_name|
            if value
              test_case.register_setup_method(method_name)
            else
              test_case.unregister_setup_method(method_name)
            end
          end
          observe_teardown = Proc.new do |test_case, _, _, value, method_name|
            if value
              test_case.register_teardown_method(method_name)
            else
              test_case.unregister_teardown_method(method_name)
            end
          end
          base.register_attribute_observer(:setup, &observe_setup)
          base.register_attribute_observer(:teardown, &observe_teardown)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def setup(*method_names)
          attribute(:setup, true, *method_names)
        end

        def unregister_setup(*method_names)
          attribute(:setup, false, *method_names)
        end

        def teardown(*method_names)
          attribute(:teardown, true, *method_names)
        end

        def unregister_teardown(*method_names)
          attribute(:teardown, false, *method_names)
        end

        @@setup_methods = []
        def register_setup_method(method_name)
          @@setup_methods |= [method_name]
        end

        def unregister_setup_method(method_name)
          @@setup_methods -= [method_name]
        end

        def setup_methods
          @@setup_methods
        end

        @@teardown_methods = []
        def register_teardown_method(method_name)
          @@teardown_methods |= [method_name]
        end

        def unregister_teardown_method(method_name)
          @@teardown_methods -= [method_name]
        end

        def teardown_methods
          @@teardown_methods
        end
      end

      private
      def run_setup
        [:setup, *self.class.setup_methods].each do |method_name|
          send(method_name) if respond_to?(method_name, true)
        end
      end

      def run_teardown
        [:teardown, *self.class.teardown_methods].each do |method_name|
          send(method_name) if respond_to?(method_name, true)
        end
      end
    end
  end
end
