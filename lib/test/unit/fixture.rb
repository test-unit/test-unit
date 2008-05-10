module Test
  module Unit
    module Fixture
      class << self
        def included(base)
          base.extend(ClassMethods)
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

        def register_setup_method(method_name)
          @setup_methods ||= []
          @setup_methods |= [method_name]
        end

        def unregister_setup_method(method_name)
          @unregistered_setup_methods ||= []
          @unregistered_setup_methods |= [method_name]
        end

        def setup_methods
          interested_ancestors = ancestors[0, ancestors.index(Fixture)].reverse
          interested_ancestors.inject([]) do |result, ancestor|
            if ancestor.is_a?(Class)
              ancestor.class_eval do
                @setup_methods ||= []
                @unregistered_setup_methods ||= []
                result + @setup_methods - @unregistered_setup_methods
              end
            else
              []
            end
          end
        end

        def register_teardown_method(method_name)
          @teardown_methods ||= []
          @teardown_methods |= [method_name]
        end

        def unregister_teardown_method(method_name)
          @unregistered_teardown_methods ||= []
          @unregistered_teardown_methods |= [method_name]
        end

        def teardown_methods
          interested_ancestors = ancestors[0, ancestors.index(Fixture)].reverse
          interested_ancestors.inject([]) do |result, ancestor|
            if ancestor.is_a?(Class)
              ancestor.class_eval do
                @teardown_methods ||= []
                @unregistered_teardown_methods ||= []
                result + @teardown_methods - @unregistered_teardown_methods
              end
            else
              []
            end
          end
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
