require "test/unit"

class TestUnitOutput < Test::Unit::TestCase
  class << self
    # capture_output replaces process global $stdout/$stderr.
    def parallel_safe?
      false
    end
  end

  def test_capture_output
    assert_equal(["stdout\n", "stderr\n"],
                 capture_output do
                   puts("stdout")
                   warn("stderr")
                 end)
  end

  def test_capture_output_nested
    inner_result = nil
    outer_result = capture_output do
      puts("outer")
      inner_result = capture_output do
        puts("inner")
      end
      puts("outer2")
    end
    assert_equal([
                   ["outer\nouter2\n", ""],
                   ["inner\n", ""],
                 ],
                 [outer_result, inner_result])
  end

  def test_capture_output_in_parallel_threads
    threads = 8.times.collect do |i|
      Thread.new do
        capture_output do
          10.times do
            puts("stdout#{i}")
            warn("stderr#{i}")
            Thread.pass
          end
        end
      end
    end
    expected = 8.times.collect do |i|
      ["stdout#{i}\n" * 10, "stderr#{i}\n" * 10]
    end
    assert_equal(expected, threads.collect(&:value))
  end

  def test_capture_output_thread_in_block
    stdout, = capture_output do
      Thread.new {puts("other")}.join
      puts("mine")
    end
    assert_equal("other\nmine\n", stdout)
  end

  class Capturer
    include Test::Unit::Util::Output
  end

  ractor
  def test_capture_output_in_ractor
    unless defined?(Ractor.store_if_absent)
      omit("Ractor.store_if_absent is required")
    end
    if Test::Unit.box_available?
      omit("require in non-main Ractor doesn't work with Ruby Box")
    end
    ractor = Ractor.new do
      Capturer.new.capture_output do
        puts("stdout")
        warn("stderr")
      end
    end
    result = ractor.respond_to?(:value) ? ractor.value : ractor.take
    assert_equal(["stdout\n", "stderr\n"], result)
  end
end
