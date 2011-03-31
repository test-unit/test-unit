module Test
  module Unit
    module Data
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def data(set_data)
          attribute(:data, set_data)
        end
      end
    end
  end
end
