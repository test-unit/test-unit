module Test
  module Unit
    module Data
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def data(*arguments, &block)
          n_arguments = arguments.size
          case n_arguments
          when 0
            data_set = block
          when 1
            data_set = arguments[0]
          when 2
            data_set = {arguments[0] => arguments[1]}
          else
            message= "wrong number arguments(#{n_arguments} for 1..2)"
            raise ArgumentError, message
          end
          current_data = current_attribute(:data)[:value] || []
          attribute(:data, current_data + [data_set])
        end

        def load_data(filename)
          case filename
          when /\.csv/i
            require 'csv'
            CSV.foreach(filename,
                        :headers => true,
                        :converters => :numeric) do |row|
              data = row.to_hash
              label = data.delete("label")
              data(label, data)
            end
          else
            raise ArgumentError, "unsupported file format: <#{filename}>"
          end
        end
      end
    end
  end
end
