module Test
  module Unit
    module Data
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        # This method provides Data-Driven-Test functionality.
        #
        # Define test data in the test code.
        #
        # @overload data(label, data)
        #   @param [String] label specify test case name.
        #   @param data specify test data.
        #
        #   @example data(label, data)
        #     data("empty string", [true, ""])
        #     data("plain string", [false, "hello"])
        #     def test_empty?(data)
        #       expected, target = data
        #       assert_equal(expected, target.empty?)
        #     end
        #
        # @overload data(data_set)
        #   @param [Hash] data_set specify test data as a Hash that
        #     key is test label and value is test data.
        #
        #   @example data(data_set)
        #     data("empty string" => [true, ""],
        #          "plain string" => [false, "hello"])
        #     def test_empty?(data)
        #       expected, target = data
        #       assert_equal(expected, target.empty?)
        #     end
        #
        # @overload data(&block)
        #   @yieldreturn [Hash] return test data set as a Hash that
        #     key is test label and value is test data.
        #
        #   @example data(&block)
        #     data do
        #       data_set = {}
        #       data_set["empty string"] = [true, ""]
        #       data_set["plain string"] = [false, "hello"]
        #       data_set
        #     end
        #     def test_empty?(data)
        #       expected, target = data
        #       assert_equal(expected, target.empty?)
        #     end
        #
        def data(*arguments, &block)
          n_arguments = arguments.size
          case n_arguments
          when 0
            raise ArgumentError, "no block is given" unless block_given?
            data_set = block
          when 1
            data_set = arguments[0]
          when 2
            data_set = {arguments[0] => arguments[1]}
          else
            message = "wrong number arguments(#{n_arguments} for 1..2)"
            raise ArgumentError, message
          end
          current_data = current_attribute(:data)[:value] || []
          attribute(:data, current_data + [data_set])
        end

        # TODO: WRITE ME.
        def load_data(file_name)
          case File.extname(file_name).downcase
          when ".csv"
            loader = CSVDataLoader.new(self)
            loader.load(file_name)
          else
            raise ArgumentError, "unsupported file format: <#{file_name}>"
          end
        end

        class CSVDataLoader
          def initialize(test_case)
            @test_case = test_case
          end

          def load(file_name)
            require 'csv'
            header = nil
            CSV.foreach(file_name) do |row|
              header = row if header.nil?
              label = nil

              if header.first == "label"
                next if header == row
                data = {}
                header.each_with_index do |key, i|
                  if key == "label"
                    label = row[i]
                  else
                    data[key] = normalize_value(row[i])
                  end
                end
              else
                label = row.shift
                data = row.collect do |cell|
                  normalize_value(cell)
                end
              end
              @test_case.data(label, data)
            end
          end

          private
          def normalize_value(value)
            return true if value == "true"
            return false if value == "false"
            begin
              Integer(value)
            rescue ArgumentError
              begin
                Float(value)
              rescue ArgumentError
                value
              end
            end
          end
        end
      end
    end
  end
end
