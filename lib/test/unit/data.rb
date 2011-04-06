module Test
  module Unit
    module Data
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def data(*data_set)
          n_arguments = data_set.size
          case n_arguments
          when 1
            data_set = data_set[0]
          when 2
            data_set = {data_set[0] => data_set[1]}
          else
            message= "wrong number arguments(#{n_arguments} for 1..2)"
            raise ArgumentError, message
          end
          current_data = current_attribute(:data)[:value] || {}
          attribute(:data, current_data.merge(data_set))
        end
      end
    end
  end
end
