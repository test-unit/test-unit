## 1. First step of the `test-unit`

Let's getting start `test-unit`.

This document creates an example gem package called `sample` with the `test-unit` testing framework.

## 2. Install bundler and test-unit.

* First, install the `bundler` gem for generating gem template.
* Second, install the `test-unit` itself.

~~~
!!!plain
gem install bundler
gem install test-unit
~~~

The `gem list` command output installed packages.
You will find the following lines.

~~~
!!!plain
gem list
...
bundler (2.6.3, default: 2.6.2)
...
test-unit (3.6.8, 3.6.7)
~~~

## 3. Create gem template.

Next, create a gem template using `bundler` command.
This command generates package skeleton with a testing framework.

The `bundle gem -t test-unit sample` command will generate a gem template with the `test-unit` testing framework.

## 4. Execute test.

The `rake test` command execute test scenarios in the `test` directory.
Now it tries to two tests. One will success the other one fails.

~~~
!!!plain
rake test
Loaded suite
/path/to/ruby/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/rake_test_loader
Started
F
================================================================================
Failure: <false> is not true.
test_it_does_something_useful(SampleTest)
/path/to/sample/test/sample_test.rb:9:in `test_it_does_something_useful'
      6:   end
      7:
      8:   def test_it_does_something_useful
  =>  9:     assert false
     10:   end
     11: end
================================================================================
.

Finished in 0.011521 seconds.
--------------------------------------------------------------------------------
2 tests, 2 assertions, 1 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
50% passed
--------------------------------------------------------------------------------
173.60 tests/s, 173.60 assertions/s
rake aborted!
Command failed with status (1)

Tasks: TOP => test
(See full trace by running task with --trace)
~~~

## 5. Create original tests.

Let's create your original tests with the following rules.

* Create a test file in the `test` directory.
* The file needs suffix  `xxx_test.rb`.
* You can put test file into the subdirectory like `test/sub`.

Example directory layout.

~~~
!!!plain
test
|-- sample_test.rb
|-- sub
|   `-- sample2_test.rb
`-- test_helper.rb
~~~

Example test file in the sub directory.

~~~
!!!ruby
require 'test_helper'

module Sub
  class Sample2Test < Test::Unit::TestCase
    def test_that_it_has_a_version_number
      refute_nil ::Sample::VERSION
    end

    def test_it_does_something_useful
      assert false
    end
  end
end
~~~

## 6. For more information

Let's read the official document.

* [test-unit](https://test-unit.github.io/index.html)
