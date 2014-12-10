module Test
  module Unit
    class CodeSnippetFetcher
      def initialize
        @sources = {}
      end

      def fetch(path, line, options={})
        n_context_line = options[:n_context_line] || 3
        lines = source(path)
        return [] if lines.nil?
        min_line = [line - n_context_line, 1].max
        max_line = [line + n_context_line, lines.length].min
        window = min_line..max_line
        window.collect do |n|
          attributes = {:target_line? => (n == line)}
          [n, lines[n - 1].chomp, attributes]
        end
      end

      def source(path)
        @sources[path] ||= read_source(path)
      end

      private
      def read_source(path)
        return nil unless File.exist?(path)
        File.readlines(path)
      end
    end
  end
end
