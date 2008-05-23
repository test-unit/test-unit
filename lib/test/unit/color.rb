module Test
  module Unit
    class Color
      NAMES = ["black", "red", "green", "yellow",
               "blue", "magenta", "cyan", "white"]
      def initialize(name, options={})
        @name = name
        @foreground = options[:foreground]
        @foreground = true if @foreground.nil?
        @intensity = options[:intensity]
        @bold = options[:bold]
        @italic = options[:italic]
        @underline = options[:underline]
      end

      def sequence
        sequence = []
        if @name == "none"
        elsif @name == "reset"
          sequence << "0"
        else
          foreground_parameter = @foreground ? 3 : 4
          foreground_parameter += 6 if @intensity
          sequence << "#{foreground_parameter}#{NAMES.index(@name)}"
        end
        sequence << "1" if @bold
        sequence << "3" if @italic
        sequence << "4" if @underline
        sequence
      end

      def escape_sequence
        "\e[#{sequence.join(';')}m"
      end

      def +(other)
        MixColor.new([self, other])
      end
    end

    class MixColor
      def initialize(colors)
        @colors = colors
      end

      def sequence
        @colors.inject([]) do |result, color|
          result + color.sequence
        end
      end

      def escape_sequence
        "\e[#{sequence.join(';')}m"
      end

      def +(other)
        self.class.new([self, other])
      end
    end
  end
end
