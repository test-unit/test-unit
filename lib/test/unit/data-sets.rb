module Test
  module Unit
    class DataSets
      def initialize
        @variables = []
        @procs = []
        @value_sets = []
      end

      def <<(data_set)
        if data_set.respond_to?(:call)
          @procs << data_set
        elsif data_set.is_a?(Array)
          @variables << data_set
        else
          @value_sets << data_set
        end
      end

      def each
        variables = @variables
        value_sets = @value_sets
        @procs.each do |proc|
          data_set = proc.call
          case data_set
          when Array
            variables += [data_set]
          else
            value_sets += [data_set]
          end
        end

        value_sets.each do |values|
          values.each do |label, data|
            yield(label, data)
          end
        end

        build_matrix(variables).each do |label, data|
          yield(label, data)
        end
      end

      def ==(other)
        @variables == other.instance_variable_get(:@variables) and
          @procs == other.instance_variable_get(:@procs) and
          @value_sets == other.instance_variable_get(:@value_sets)
      end

      def eql?(other)
        self == other
      end

      def hash
        [@variables, @procs, @value_sets].hash
      end

      private
      def build_matrix(variables)
        build_raw_matrix(variables).collect do |cell|
          label = String.new
          data = cell[:data]
          cell[:variables].sort.each do |variable|
            unless label.empty?
              label << ", "
            end
            label << "#{variable}: #{data[variable].inspect}"
          end
          [label, data]
        end
      end

      def build_raw_matrix(variables)
        return [] if variables.empty?

        (variable, patterns), *rest_variables = variables
        sub_matrix = build_raw_matrix(rest_variables)
        return sub_matrix if patterns.empty?

        matrix = []
        patterns.each do |pattern|
          if sub_matrix.empty?
            matrix << {
              :variables => [variable],
              :data => {variable => pattern},
            }
          else
            sub_matrix.each do |sub_cell|
              matrix << {
                :variables => [variable, *sub_cell[:variables]],
                :data => sub_cell[:data].merge(variable => pattern),
              }
            end
          end
        end
        matrix
      end
    end
  end
end
