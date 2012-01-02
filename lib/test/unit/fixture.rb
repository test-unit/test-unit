module Test
  module Unit
    module Fixture
      class << self
        def included(base)
          base.extend(ClassMethods)

          [:setup, :cleanup, :teardown].each do |fixture|
            observer = lambda do |test_case, _, _, value, callback|
              if value.nil?
                test_case.send("unregister_#{fixture}_callback", callback)
              else
                test_case.send("register_#{fixture}_callback", callback, value)
              end
            end
            base.register_attribute_observer(fixture, &observer)
          end
        end
      end

      module ClassMethods
        def setup(*method_names, &callback)
          register_fixture(:setup, *method_names, &callback)
        end

        def unregister_setup(*method_names_or_callbacks)
          unregister_fixture(:setup, *method_names_or_callbacks)
        end

        def cleanup(*method_names, &callback)
          register_fixture(:cleanup, *method_names, &callback)
        end

        def unregister_cleanup(*method_names_or_callbacks)
          unregister_fixture(:cleanup, *method_names_or_callbacks)
        end

        def teardown(*method_names, &callback)
          register_fixture(:teardown, *method_names, &callback)
        end

        def unregister_teardown(*method_names_or_callbacks)
          unregister_fixture(:teardown, *method_names_or_callbacks)
        end

        def register_setup_callback(method_name_or_callback, options)
          register_fixture_callback(:setup, method_name_or_callback,
                                    options, :after, :append)
        end

        def unregister_setup_callback(method_name_or_callback)
          unregister_fixture_callback(:setup, method_name_or_callback)
        end

        def register_cleanup_callback(method_name_or_callback, options)
          register_fixture_callback(:cleanup, method_name_or_callback,
                                    options, :before, :prepend)
        end

        def unregister_cleanup_callback(method_name_or_callback)
          unregister_fixture_callback(:cleanup, method_name_or_callback)
        end

        def register_teardown_callback(method_name_or_callback, options)
          register_fixture_callback(:teardown, method_name_or_callback,
                                    options, :before, :prepend)
        end

        def unregister_teardown_callback(method_name_or_callback)
          unregister_fixture_callback(:teardown, method_name_or_callback)
        end

        def before_setup_callbacks
          collect_fixture_callbacks(:setup, :before)
        end

        def after_setup_callbacks
          collect_fixture_callbacks(:setup, :after)
        end

        def before_cleanup_callbacks
          collect_fixture_callbacks(:cleanup, :before)
        end

        def after_cleanup_callbacks
          collect_fixture_callbacks(:cleanup, :after)
        end

        def before_teardown_callbacks
          collect_fixture_callbacks(:teardown, :before)
        end

        def after_teardown_callbacks
          collect_fixture_callbacks(:teardown, :after)
        end

        private
        def register_fixture(fixture, *method_names, &callback)
          options = {}
          options = method_names.pop if method_names.last.is_a?(Hash)
          callbacks = method_names
          callbacks << callback if callback
          attribute(fixture, options, *callbacks)
        end

        def unregister_fixture(fixture, *method_names_or_callbacks)
          attribute(fixture, nil, *method_names_or_callbacks)
        end

        def valid_register_fixture_options?(options)
          return true if options.empty?
          return false if options.size > 1

          key = options.keys.first
          [:before, :after].include?(key) and
            [:prepend, :append].include?(options[key])
        end

        def add_fixture_callback(how, variable_name, method_name_or_callback)
          callbacks = instance_eval("#{variable_name} ||= []")

          if how == :prepend
            callbacks = [method_name_or_callback] | callbacks
          else
            callbacks = callbacks | [method_name_or_callback]
          end
          instance_variable_set(variable_name, callbacks)
        end

        def registered_callbacks_variable_name(fixture, order)
          "@#{order}_#{fixture}_callbacks"
        end

        def unregistered_callbacks_variable_name(fixture)
          "@unregistered_#{fixture}_callbacks"
        end

        def register_fixture_callback(fixture, method_name_or_callback, options,
                                      default_order, default_how)
          unless valid_register_fixture_options?(options)
            message = "must be {:before => :prepend}, " +
              "{:before => :append}, {:after => :prepend} or " +
              "{:after => :append}: #{options.inspect}"
            raise ArgumentError, message
          end

          if options.empty?
            order, how = default_order, default_how
          else
            order, how = options.to_a.first
          end
          variable_name = registered_callbacks_variable_name(fixture, order)
          add_fixture_callback(how, variable_name, method_name_or_callback)
        end

        def unregister_fixture_callback(fixture, method_name_or_callback)
          variable_name = unregistered_callbacks_variable_name(fixture)
          add_fixture_callback(:append, variable_name, method_name_or_callback)
        end

        def collect_fixture_callbacks(fixture, order)
          callbacks_variable = registered_callbacks_variable_name(fixture, order)
          unregistered_callbacks_variable =
            unregistered_callbacks_variable_name(fixture)

          base_index = ancestors.index(Fixture)
          interested_ancestors = ancestors[0, base_index].reverse
          interested_ancestors.inject([]) do |result, ancestor|
            if ancestor.is_a?(Class)
              ancestor.class_eval do
                callbacks = instance_eval("#{callbacks_variable} ||= []")
                unregistered_callbacks =
                  instance_eval("#{unregistered_callbacks_variable} ||= []")
                (result | callbacks) - unregistered_callbacks
              end
            else
              result
            end
          end
        end
      end

      private
      def run_fixture(fixture, options={})
        [
         self.class.send("before_#{fixture}_callbacks"),
         fixture,
         self.class.send("after_#{fixture}_callbacks")
        ].flatten.each do |method_name_or_callback|
          run_fixture_callback(method_name_or_callback, options)
        end
      end

      def run_fixture_callback(method_name_or_callback, options)
        if method_name_or_callback.respond_to?(:call)
          callback = lambda do
            instance_eval(&method_name_or_callback)
          end
        else
          return unless respond_to?(method_name_or_callback, true)
          callback = lambda do
            send(method_name_or_callback)
          end
        end

        begin
          callback.call
        rescue Exception
          raise unless options[:handle_exception]
          raise unless handle_exception($!)
        end
      end

      def run_setup
        run_fixture(:setup)
      end

      def run_cleanup
        run_fixture(:cleanup)
      end

      def run_teardown
        run_fixture(:teardown, :handle_exception => true)
      end
    end
  end
end
