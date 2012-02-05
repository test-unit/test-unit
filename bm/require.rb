require 'benchmark'

gem 'test-unit', '=2.4.5'

Benchmark.bm do |x|
  x.report { 
    require 'test/unit' 
    Test::Unit.run = true
  }
end

