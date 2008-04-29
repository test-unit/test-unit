module Test
  module Unit
    module Attribute
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def method_added(name)
          super
          if defined?(@current_attributes)
            attributes = {}
            kept_attributes = {}
            @current_attributes.each do |attribute_name, attribute|
              attributes[attribute_name] = attribute[:value]
              kept_attributes[attribute_name] = attribute if attribute[:keep]
            end
            set_attributes(name, attributes)
            @current_attributes = kept_attributes
          end
        end

        def attribute(name, value, options={}, *method_names)
          unless options.is_a?(Hash)
            method_names << options
            options = {}
          end
          @current_attributes ||= {}
          if method_names.empty?
            @current_attributes[name] = options.merge(:value => value)
          else
            method_names.each do |method_names|
              set_attribute(method_name, {name => value})
            end
          end
        end

        def set_attributes(method_name, attributes)
          return if attributes.empty?
          method_name = normalize_method_name(method_name)
          @attributes ||= {}
          @attributes[method_name] ||= {}
          @attributes[method_name] = @attributes[method_name].merge(attributes)
        end

        def attributes(method_name)
          method_name = normalize_method_name(method_name)
          @attributes ||= {}
          @attributes[method_name]
        end

        private
        def normalize_method_name(name)
          name.to_s
        end
      end

      def attributes
        self.class.attributes(@method_name) || {}
      end
    end
  end
end
