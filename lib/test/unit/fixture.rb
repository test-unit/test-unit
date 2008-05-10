module Test
  module Unit
    module Fixture
      class << self
        def included(base)
          base.extend(ClassMethods)

          [:setup, :teardown].each do |fixture|
            observer = Proc.new do |test_case, _, _, value, method_name|
              if value
                test_case.send("register_#{fixture}_method", method_name)
              else
                test_case.send("unregister_#{fixture}_method", method_name)
              end
            end
            base.register_attribute_observer(fixture, &observer)
          end
        end
      end

      module ClassMethods
        [:setup, :teardown].each do |fixture|
          class_eval do
            define_method(fixture) do |*method_names|
              attribute(fixture, true, *method_names)
            end

            define_method("unregister_#{fixture}") do |*method_names|
              attribute(fixture, false, *method_names)
            end
          end

          append_method_name = Proc.new do |variable_name|
            Proc.new do |method_name|
              unless instance_variable_defined?(variable_name)
                instance_variable_set(variable_name, [])
              end
              methods = instance_variable_get(variable_name) | [method_name]
              instance_variable_set(variable_name, methods)
            end
          end

          methods_name = "@#{fixture}_methods"
          define_method("register_#{fixture}_method",
                        &append_method_name.call(methods_name))

          unregistered_methods_name = "@unregistered_#{fixture}_methods"
          define_method("unregister_#{fixture}_method",
                        &append_method_name.call(unregistered_methods_name))

          define_method("#{fixture}_methods") do
            interested_ancestors = ancestors[0, ancestors.index(Fixture)].reverse
            interested_ancestors.inject([]) do |result, ancestor|
              if ancestor.is_a?(Class)
                ancestor.class_eval do
                  methods = []
                  unregistered_methods = []
                  if instance_variable_defined?(methods_name)
                    methods = instance_variable_get(methods_name)
                  end
                  if instance_variable_defined?(unregistered_methods_name)
                    unregistered_methods =
                      instance_variable_get(unregistered_methods_name)
                  end
                  result + methods - unregistered_methods
                end
              else
                []
              end
            end
          end
        end
      end

      [:setup, :teardown].each do |fixture|
        fixture_runner = "run_#{fixture}"
        define_method(fixture_runner) do
          [fixture, *self.class.send("#{fixture}_methods")].each do |method_name|
            send(method_name) if respond_to?(method_name, true)
          end
        end
        send(:private, fixture_runner)
      end
    end
  end
end
