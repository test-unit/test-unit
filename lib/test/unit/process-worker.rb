#--
#
# Author:: Tsutomu Katsube.
# Copyright:: Copyright (c) 2025 Tsutomu Katsube. All rights reserved.
# License:: Ruby license.

require "optparse"

parser = OptionParser.new
parser.on("--load-path=PATH") do |path|
  $LOAD_PATH << path
end
base_directory = nil
parser.on("--base-directory=PATH") do |path|
  base_directory = path
end
worker_id = nil
parser.on("--worker-id=ID", Integer) do |id|
  worker_id = id
end
test_paths = parser.parse!

require_relative "../unit"
require_relative "collector/load"
require_relative "process-test-result"
require_relative "worker-context"
Test::Unit::AutoRunner.need_auto_run = false
collector = Test::Unit::Collector::Load.new
collector.base = base_directory
suite = collector.collect(*test_paths)

MAIN_TO_WORKER_INPUT_FILENO = 3
WORKER_TO_MAIN_OUTPUT_FILENO = 4
data_input = IO.new(MAIN_TO_WORKER_INPUT_FILENO)
data_output = IO.new(WORKER_TO_MAIN_OUTPUT_FILENO)

loop do
  Marshal.dump({status: :ready}, data_output)
  data_output.flush
  test_name = Marshal.load(data_input)
  break if test_name.nil?
  test = suite.find(test_name)
  result = Test::Unit::ProcessTestResult.new(data_output)
  run_context = Test::Unit::TestRunContext.new(Test::Unit::TestSuiteRunner)

  event_listener = lambda do |event_name, *args|
    Marshal.dump({status: :event, event_name: event_name, args: args}, data_output)
    data_output.flush
  end
  if test.is_a?(Test::Unit::TestSuite)
    test_suite = test
  else
    test_suite = Test::Unit::TestSuite.new(test.class.name, test.class)
    test_suite << test
  end
  runner = Test::Unit::TestSuiteRunner.new(test_suite)
  worker_context = Test::Unit::WorkerContext.new(worker_id, run_context, result)
  runner.run(worker_context, &event_listener)
end
Marshal.dump({status: :done}, data_output)
data_output.flush

Marshal.load(data_input)

data_input.close
data_output.close
