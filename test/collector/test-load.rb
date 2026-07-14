require 'tmpdir'
require 'pathname'

require 'test/unit'
require 'test/unit/collector/load'

class TestUnitCollectorLoad < Test::Unit::TestCase
  class << self
    def parallel_safe?
      false
    end
  end

  def setup
    @previous_descendants = Test::Unit::TestCase::DESCENDANTS.dup
    Test::Unit::TestCase::DESCENDANTS.clear

    @temporary_test_cases_module_name = "TempTestCases"
    ::Object.const_set(@temporary_test_cases_module_name, Module.new)

    @test_dir = Pathname(Dir.tmpdir) + "test-unit-#{worker_id}"
    @extra_test_dir = Pathname(Dir.tmpdir) + "test-unit-extra-#{worker_id}"
    ensure_clean_directory(@test_dir)
    ensure_clean_directory(@extra_test_dir)
  end

  setup
  def setup_top_level_test_cases(&_)
    @test_case1_base_name = "test_case1.rb"

    @test_case1 = @test_dir + @test_case1_base_name
    @test_case2 = @test_dir + "test_case2.rb"
    @no_load_test_case3 = @test_dir + "case3.rb"

    @test_case1.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class TestCase1 < Test::Unit::TestCase
    def test1_1
    end

    def test1_2
    end
  end
end
EOT
    end

    @test_case2.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class TestCase2 < Test::Unit::TestCase
    def test2
    end
  end
end
EOT
    end

    @no_load_test_case3.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class NoLoadTestCase3 < Test::Unit::TestCase
    def test3
    end
  end
end
EOT
    end
  end

  setup
  def setup_sub_level_test_cases(&_)
    @sub_test_dir = @test_dir + "sub"
    @sub_test_dir.mkpath

    @sub_test_case1 = @sub_test_dir + @test_case1_base_name
    @sub_test_case4 = @sub_test_dir + "test_case4.rb"
    @no_load_sub_test_case5 = @sub_test_dir + "case5.rb"
    @sub_test_case6 = @sub_test_dir + "test_case6.rb"

    @sub_test_case1.open("w") do |test_case|
      test_case.puts(<<-TEST_CASE)
module #{@temporary_test_cases_module_name}
  class SubTestCase1 < Test::Unit::TestCase
    def test1_1
    end

    def test1_2
    end
  end
end
      TEST_CASE
    end

    @sub_test_case4.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SubTestCase4 < Test::Unit::TestCase
    def test4_1
    end

    def test4_2
    end
  end
end
EOT
    end

    @no_load_sub_test_case5.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class NoLoadSubTestCase5 < Test::Unit::TestCase
    def test5_1
    end

    def test5_2
    end
  end
end
EOT
    end

    @sub_test_case6.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SubTestCase6 < Test::Unit::TestCase
    def test6
    end
  end
end
EOT
    end
  end

  setup
  def setup_sub_level_test_cases2(&_)
    @sub2_test_dir = @test_dir + "sub2"
    @sub2_test_dir.mkpath

    @no_load_sub2_test_case7 = @sub2_test_dir + "case7.rb"
    @sub2_test_case8 = @sub2_test_dir + "test_case8.rb"
    @sub2_test_case9 = @sub2_test_dir + "test_case9.rb"

    @no_load_sub2_test_case7.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class NoLoadSub2TestCase7 < Test::Unit::TestCase
    def test7_1
    end

    def test7_2
    end
  end
end
EOT
    end

    @sub2_test_case8.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class Sub2TestCase8 < Test::Unit::TestCase
    def test8_1
    end

    def test8_2
    end
  end
end
EOT
    end

    @sub2_test_case9.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class Sub2TestCase9 < Test::Unit::TestCase
    def test9
    end
  end
end
EOT
    end
  end

  setup
  def setup_svn_test_cases(&_)
    @svn_test_dir = @test_dir + ".svn"
    @svn_test_dir.mkpath

    @svn_test_case10 = @svn_test_dir + "test_case10.rb"

    @svn_test_case10.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SvnTestCase10 < Test::Unit::TestCase
    def test7
    end
  end
end
EOT
    end
  end

  setup
  def setup_sub_cvs_test_cases(&_)
    @sub_cvs_test_dir = @sub_test_dir + "CVS"
    @sub_cvs_test_dir.mkpath

    @sub_cvs_test_case11 = @sub_cvs_test_dir + "test_case11.rb"

    @sub_cvs_test_case11.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SubCVSTestCase11 < Test::Unit::TestCase
    def test11
    end
  end
end
EOT
    end
  end

  setup
  def setup_sub_git_test_cases(&_)
    @sub_git_test_dir = @sub_test_dir + ".git"
    @sub_git_test_dir.mkpath

    @sub_git_test_case11 = @sub_git_test_dir + "test_case11.rb"

    @sub_git_test_case11.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SubGitTestCase11 < Test::Unit::TestCase
    def test11
    end
  end
end
EOT
    end
  end

  setup
  def setup_box_test_cases(&_)
    @box_test_dir = Pathname(Dir.tmpdir) + "test-unit-box-#{worker_id}"
    ensure_clean_directory(@box_test_dir)

    @box_test_case1 = @box_test_dir + "test_case_box1.b.rb"
    @box_suffix_test_case = @box_test_dir + "suffix_test.b.rb"
    @box_dir_plain_test_case = @box_test_dir + "test_case_plain.rb"

    @box_test_case1.open("w") do |test_case|
      test_case.puts(<<-EOT)
require "test/unit"

module #{@temporary_test_cases_module_name}
  class BoxTestCase1 < Test::Unit::TestCase
    def test_box1_1
    end

    def test_box1_2
    end
  end
end
EOT
    end

    @box_suffix_test_case.open("w") do |test_case|
      test_case.puts(<<-EOT)
require "test/unit"

module #{@temporary_test_cases_module_name}
  class BoxSuffixTestCase < Test::Unit::TestCase
    def test_suffix
    end
  end
end
EOT
    end

    @box_dir_plain_test_case.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class BoxDirPlainTestCase < Test::Unit::TestCase
    def test_plain
    end
  end
end
EOT
    end
  end

  setup
  def setup_box_same_name_test_cases(&_)
    @box_same_test_dir = Pathname(Dir.tmpdir) + "test-unit-box-same-#{worker_id}"
    ensure_clean_directory(@box_same_test_dir)

    same_name_test_case_source = <<-EOT
require "test/unit"

module #{@temporary_test_cases_module_name}
  class BoxSameNameTestCase < Test::Unit::TestCase
    def test_same
    end
  end
end
EOT
    @box_same_name_test_case1 = @box_same_test_dir + "test_case_same1.b.rb"
    @box_same_name_test_case2 = @box_same_test_dir + "test_case_same2.b.rb"
    [@box_same_name_test_case1, @box_same_name_test_case2].each do |path|
      path.open("w") do |test_case|
        test_case.puts(same_name_test_case_source)
      end
    end
  end

  setup
  def setup_box_run_test_cases(&_)
    @box_run_test_dir = Pathname(Dir.tmpdir) + "test-unit-box-run-#{worker_id}"
    ensure_clean_directory(@box_run_test_dir)

    @box_run_test_case = @box_run_test_dir + "test_case_box_run.b.rb"
    @box_run_test_case.open("w") do |test_case|
      test_case.puts(<<-EOT)
require "test/unit"

BOX_LOCAL_CONSTANT = true

class String
  def box_shout
    upcase + "!"
  end
end

module #{@temporary_test_cases_module_name}
  class BoxRunTestCase < Test::Unit::TestCase
    def test_monkey_patch_in_box
      assert_equal("HI!", "hi".box_shout)
    end

    def test_intentional_failure
      assert_equal(1, 2, "intentional failure in box")
    end
  end
end
EOT
    end
  end

  setup
  def setup_extra_top_level_test_cases(&_)
    @test_cases12 = @extra_test_dir + "test_cases12.rb"
    @test_cases12.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class TestCase121 < Test::Unit::TestCase
    def test121_1
    end

    def test121_2
    end
  end

  class TestCase122 < Test::Unit::TestCase
    def test122_1
    end

    def test122_2
    end
  end
end
EOT
    end
  end

  setup
  def setup_sub_level_extra_test_cases(&_)
    @sub_extra_test_dir = @extra_test_dir + "sub"
    @sub_extra_test_dir.mkpath

    @cases13_test = @sub_extra_test_dir + "13cases_test.rb"
    @cases13_test.open("w") do |test_case|
      test_case.puts(<<-EOT)
module #{@temporary_test_cases_module_name}
  class SubTestCase13 < Test::Unit::TestCase
    def test13_1
    end

    def test13_2
    end
  end
end
EOT
    end
  end

  def teardown
    @test_dir.rmtree if @test_dir.exist?
    @box_test_dir.rmtree if @box_test_dir.exist?
    @box_same_test_dir.rmtree if @box_same_test_dir.exist?
    @box_run_test_dir.rmtree if @box_run_test_dir.exist?
    ::Object.send(:remove_const, @temporary_test_cases_module_name)
    Test::Unit::TestCase::DESCENDANTS.replace(@previous_descendants)
  end

  def test_simple_collect
    assert_collect([:suite, {:name => @sub_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("SubTestCase1")},
                     [:test, {:name => "test1_1"}],
                     [:test, {:name => "test1_2"}]],
                    [:suite, {:name => _test_case_name("SubTestCase4")},
                     [:test, {:name => "test4_1"}],
                     [:test, {:name => "test4_2"}]],
                    [:suite, {:name => _test_case_name("SubTestCase6")},
                     [:test, {:name => "test6"}]]],
                   @sub_test_dir.to_s)
  end

  def test_simple_collect_test_suffix
    assert_collect([:suite, {:name => @extra_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("TestCase121")},
                     [:test, {:name => "test121_1"}],
                     [:test, {:name => "test121_2"}]],
                    [:suite, {:name => _test_case_name("TestCase122")},
                     [:test, {:name => "test122_1"}],
                     [:test, {:name => "test122_2"}]],
                    [:suite, {:name => @sub_extra_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("SubTestCase13")},
                      [:test, {:name => "test13_1"}],
                      [:test, {:name => "test13_2"}]]]],
                   @extra_test_dir.to_s)
  end

  def test_multilevel_collect
    assert_collect([:suite, {:name => "."},
                    [:suite, {:name => _test_case_name("TestCase1")},
                     [:test, {:name => "test1_1"}],
                     [:test, {:name => "test1_2"}]],
                    [:suite, {:name => _test_case_name("TestCase2")},
                     [:test, {:name => "test2"}]],
                    [:suite, {:name => @sub_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("SubTestCase1")},
                      [:test, {:name => "test1_1"}],
                      [:test, {:name => "test1_2"}]],
                     [:suite, {:name => _test_case_name("SubTestCase4")},
                      [:test, {:name => "test4_1"}],
                      [:test, {:name => "test4_2"}]],
                     [:suite, {:name => _test_case_name("SubTestCase6")},
                      [:test, {:name => "test6"}]]],
                   [:suite, {:name => @sub2_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("Sub2TestCase8")},
                      [:test, {:name => "test8_1"}],
                      [:test, {:name => "test8_2"}]],
                     [:suite, {:name => _test_case_name("Sub2TestCase9")},
                      [:test, {:name => "test9"}]]]])
  end

  def test_collect_file
    assert_collect([:suite, {:name => _test_case_name("TestCase1")},
                    [:test, {:name => "test1_1"}],
                    [:test, {:name => "test1_2"}]],
                   @test_case1.to_s)
  end

  def test_collect_file_no_pattern_match_file_name
    assert_collect([:suite, {:name => _test_case_name("NoLoadSubTestCase5")},
                    [:test, {:name => "test5_1"}],
                    [:test, {:name => "test5_2"}]],
                   @no_load_sub_test_case5.to_s)
  end

  def test_collect_file_test_cases
    assert_collect([:suite, {:name => "[#{@test_cases12}]"},
                    [:suite, {:name => _test_case_name("TestCase121")},
                     [:test, {:name => "test121_1"}],
                     [:test, {:name => "test121_2"}]],
                    [:suite, {:name => _test_case_name("TestCase122")},
                     [:test, {:name => "test122_1"}],
                     [:test, {:name => "test122_2"}]]],
                   @test_cases12.to_s)
  end

  def test_collect_files
    assert_collect([:suite,
                    {:name => "[#{@test_case1}, #{@test_case2}]"},
                    [:suite, {:name => _test_case_name("TestCase1")},
                     [:test, {:name => "test1_1"}],
                     [:test, {:name => "test1_2"}]],
                    [:suite, {:name => _test_case_name("TestCase2")},
                     [:test, {:name => "test2"}]]],
                   @test_case1.to_s, @test_case2.to_s)
  end

  def test_nil_pattern
    assert_collect([:suite, {:name => @sub_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("NoLoadSubTestCase5")},
                     [:test, {:name => "test5_1"}],
                     [:test, {:name => "test5_2"}]],
                    [:suite, {:name => _test_case_name("SubTestCase1")},
                     [:test, {:name => "test1_1"}],
                     [:test, {:name => "test1_2"}]],
                    [:suite, {:name => _test_case_name("SubTestCase4")},
                     [:test, {:name => "test4_1"}],
                     [:test, {:name => "test4_2"}]],
                    [:suite, {:name => _test_case_name("SubTestCase6")},
                     [:test, {:name => "test6"}]]],
                   @sub_test_dir.to_s) do |collector|
      collector.patterns.clear
    end
  end

  def test_filtering
    assert_collect([:suite, {:name => "."},
                    [:suite, {:name => _test_case_name("TestCase1")},
                     [:test, {:name => "test1_1"}],
                     [:test, {:name => "test1_2"}]],
                    [:suite, {:name => @sub_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("SubTestCase1")},
                      [:test, {:name => "test1_1"}],
                      [:test, {:name => "test1_2"}]]]]) do |collector|
      collector.filter = Proc.new do |test|
        !/\Atest1/.match(test.method_name).nil?
      end
    end
  end

  def test_collect_multi
    test_dirs = [@sub_test_dir.to_s, @sub2_test_dir.to_s]
    assert_collect([:suite, {:name => "[#{test_dirs.join(', ')}]"},
                    [:suite, {:name => @sub_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("SubTestCase1")},
                      [:test, {:name => "test1_1"}],
                      [:test, {:name => "test1_2"}]],
                     [:suite, {:name => _test_case_name("SubTestCase4")},
                      [:test, {:name => "test4_1"}],
                      [:test, {:name => "test4_2"}]],
                     [:suite, {:name => _test_case_name("SubTestCase6")},
                      [:test, {:name => "test6"}]]],
                    [:suite, {:name => @sub2_test_dir.basename.to_s},
                     [:suite, {:name => _test_case_name("Sub2TestCase8")},
                      [:test, {:name => "test8_1"}],
                      [:test, {:name => "test8_2"}]],
                     [:suite, {:name => _test_case_name("Sub2TestCase9")},
                      [:test, {:name => "test9"}]]]],
                   *test_dirs)
  end

  def test_collect_box_file
    omit_unless_box_available
    assert_collect([:suite, {:name => _test_case_name("BoxTestCase1")},
                    [:test, {:name => "test_box1_1"}],
                    [:test, {:name => "test_box1_2"}]],
                   @box_test_case1.to_s)
  end

  def test_collect_box_directory
    omit_unless_box_available
    assert_collect([:suite, {:name => @box_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("BoxDirPlainTestCase")},
                     [:test, {:name => "test_plain"}]],
                    [:suite, {:name => _test_case_name("BoxSuffixTestCase")},
                     [:test, {:name => "test_suffix"}]],
                    [:suite, {:name => _test_case_name("BoxTestCase1")},
                     [:test, {:name => "test_box1_1"}],
                     [:test, {:name => "test_box1_2"}]]],
                   @box_test_dir.to_s)
  end

  def test_collect_box_per_file
    omit_unless_box_available
    assert_collect([:suite, {:name => @box_same_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("BoxSameNameTestCase")},
                     [:test, {:name => "test_same"}]],
                    [:suite, {:name => _test_case_name("BoxSameNameTestCase")},
                     [:test, {:name => "test_same"}]]],
                   @box_same_test_dir.to_s)
  end

  def test_box_filtering
    omit_unless_box_available
    assert_collect([:suite, {:name => @box_test_dir.basename.to_s},
                    [:suite, {:name => _test_case_name("BoxTestCase1")},
                     [:test, {:name => "test_box1_1"}]]],
                   @box_test_dir.to_s) do |collector|
      collector.filter = Proc.new do |test|
        test.method_name == "test_box1_1"
      end
    end
  end

  def test_collect_box_file_without_box
    collector = Test::Unit::Collector::Load.new
    def collector.box_available?
      false
    end
    assert_raise(Test::Unit::Collector::Load::BoxUnavailableError) do
      collector.collect(@box_test_case1.to_s)
    end
  end

  def test_run_box_tests
    omit_unless_box_available

    suite = nil
    keep_required_files do
      collector = Test::Unit::Collector::Load.new
      suite = collector.collect(@box_run_test_case.to_s)
    end

    result = Test::Unit::TestResult.new
    Test::Unit::TestSuiteRunner.run_all_tests(result, {}) do |run_context|
      worker_context = Test::Unit::WorkerContext.new(nil, run_context, result)
      suite.run(worker_context) {}
    end

    # The tests defined in the .b.rb file are really run and their
    # results are collected into the current box's TestResult. The
    # monkey patch test passes only when String#box_shout defined in
    # the .b.rb file is effective in the box.
    assert_equal([2, 2, 1],
                 [result.run_count,
                  result.assertion_count,
                  result.failure_count])
    assert_equal(["test_intentional_failure" +
                  "(#{_test_case_name('BoxRunTestCase')})"],
                 result.faults.collect {|fault| fault.test_name})
    assert_match(/intentional failure in box/,
                 result.faults.first.message)

    # The monkey patch and the constant defined in the .b.rb file
    # must not leak into the current box.
    assert_not_respond_to("hi", :box_shout)
    assert_false(::Object.const_defined?(:BOX_LOCAL_CONSTANT))
  end

  private
  def omit_unless_box_available
    unless Test::Unit.box_available?
      omit("Ruby::Box is required")
    end
  end

  def assert_collect(expected, *collect_args)
    keep_required_files do
      Dir.chdir(@test_dir.to_s) do
        collector = Test::Unit::Collector::Load.new
        yield(collector) if block_given?
        actual = inspect_test_object(collector.collect(*collect_args))
        assert_equal(expected, actual)
      end
    end
  end

  def ensure_clean_directory(directory)
    directory.rmtree if directory.exist?
    directory.mkpath
  end

  def keep_required_files
    required_files = $".dup
    yield
  ensure
    $".replace(required_files)
  end

  def _test_case_name(test_case_class_name)
    "#{@temporary_test_cases_module_name}::#{test_case_class_name}"
  end

  def inspect_test_object(test_object)
    return nil if test_object.nil?
    # Use duck typing instead of case/when with TestSuite/TestCase
    # because test_object may be defined in another Ruby::Box, which
    # is a different class object.
    if test_object.respond_to?(:tests)
      sub_tests = test_object.tests.collect do |test|
        inspect_test_object(test)
      end.sort_by do |type, attributes, *children|
        attributes[:name]
      end
      [:suite, {:name => test_object.name}, *sub_tests]
    elsif test_object.respond_to?(:method_name)
      [:test, {:name => test_object.method_name}]
    else
      raise "unexpected test object: #{test_object.inspect}"
    end
  end
end
