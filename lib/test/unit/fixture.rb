module Test
  module Unit
    module Fixture
      class << self
        def included(base)
          base.extend(ClassMethods)

          [:setup, :teardown].each do |fixture|
            observer = Proc.new do |test_case, _, _, value, method_name|
              if value.nil?
                test_case.send("unregister_#{fixture}_method", method_name)
              else
                test_case.send("register_#{fixture}_method", method_name,
                               value)
              end
            end
            base.register_attribute_observer(fixture, &observer)
          end
        end
      end

      module ClassMethods
        def valid_register_fixture_options?(options)
          return true if options.empty?
          return false if options.size > 1

          key = options.keys.first
          [:before, :after].include?(key) and
            [:prepend, :append].include?(options[key])
        end

        [:setup, :teardown].each do |fixture|
          class_eval do
            define_method(fixture) do |*method_names|
              options = {}
              options = method_names.pop if method_names.last.is_a?(Hash)
              attribute(fixture, options, *method_names)
            end

            define_method("unregister_#{fixture}") do |*method_names|
              attribute(fixture, nil, *method_names)
            end
          end

          add_method_name = Proc.new do |klass, type, variable_name, method_name|
            unless klass.instance_variable_defined?(variable_name)
              klass.instance_variable_set(variable_name, [])
            end
            methods = klass.instance_variable_get(variable_name)

            if type == :prepend
              methods = [method_name] | methods
            else
              methods = methods | [method_name]
            end
            klass.instance_variable_set(variable_name, methods)
          end

          base_methods_variable_suffix = "#{fixture}_methods"
          define_method("register_#{fixture}_method") do |method_name, options|
            unless valid_register_fixture_options?(options)
              message = "must be {:before => :prepend}, " +
                "{:before => :append}, {:after => :prepend} or " +
                "{:after => :append}: #{options.inspect}"
              raise ArgumentError, message
            end

            if options.empty?
              if fixture == :setup
                order, type = :after, :append
              else
                order, type = :before, :prepend
              end
            else
              order, type = options.to_a.first
            end
            variable_name = "@#{order}_#{base_methods_variable_suffix}"
            add_method_name.call(self, type, variable_name, method_name)
          end

          unregistered_methods_variable =
            "@unregistered_#{base_methods_variable_suffix}"
          define_method("unregister_#{fixture}_method") do |method_name|
            add_method_name.call(self, :append, unregistered_methods_variable,
                                 method_name)
          end

          [:before, :after].each do |order|
            define_method("#{order}_#{fixture}_methods") do
              base_index = ancestors.index(Fixture)
              interested_ancestors = ancestors[0, base_index].reverse
              interested_ancestors.inject([]) do |result, ancestor|
                if ancestor.is_a?(Class)
                  ancestor.class_eval do
                    methods = []
                    unregistered_methods = []
                    methods_variable =
                      "@#{order}_#{base_methods_variable_suffix}"
                    if instance_variable_defined?(methods_variable)
                      methods = instance_variable_get(methods_variable)
                    end
                    if instance_variable_defined?(unregistered_methods_variable)
                      unregistered_methods =
                        instance_variable_get(unregistered_methods_variable)
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
      end

      [:setup, :teardown].each do |fixture|
        fixture_runner = "run_#{fixture}"
        define_method(fixture_runner) do
          [
           self.class.send("before_#{fixture}_methods"),
           fixture,
           self.class.send("after_#{fixture}_methods")
          ].flatten.each do |method_name|
            send(method_name) if respond_to?(method_name, true)
          end
        end
        send(:private, fixture_runner)
      end
    end
  end
end
