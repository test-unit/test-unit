# News

## 3.6.9 - 2025-06-29 {#version-3-6-9}

### Improvements

  * doc: test: Added one-line style to declare `Ractor` test.
    * GH-261
    * GH-309

  * Used `require_relative` instead of `require` for internal library
    files.
    * GH-311
    * GH-312
    * GH-313
    * GH-315

  * Added the `--version` option.
    * GH-314
    * Patch by MSP-Greg

### Thanks

  * MSP-Greg

## 3.6.8 - 2025-04-05 {#version-3-6-8}

### Improvements

  * `test-unit`: Added. You can use this instead of creating a custom
    test run script.
    * GH-288
    * GH-289
    * GH-291
    * Suggested by gemmaro

  * Updated the "how to" document.
    * GH-292
    * GH-293
    * GH-294

  * Updated the "getting started" document.
    * GH-295
    * GH-296

  * Added support for `.test-unit` configuration file. It's useful for
    specifying default options, and is handier than using `.test-unit.yml`.
    * GH-300
    * GH-302

### Fixes

  * parallel: thread: Fixed shutdown execution order.
    * GH-282

  * testcase: Fixed a bug that instance variables added during the test
    runs are not garbage collected after each test run.
    * GH-235
    * GH-303
    * Reported by akira yamada

### Thanks

  * gemmaro

  * akira yamada

## 3.6.7 - 2024-12-17 {#version-3-6-7}

### Fixes

  * Fixed a bug that test-unit doesn't work with Ruby < 2.5.

## 3.6.6 - 2024-12-17 {#version-3-6-6}

### Improvements

  * Improved backward compatibility for the `Test::Unit::TestCase#run`
    overriding case. In general, we don't recommend it but there are
    old scripts that do it. (Mainly, I did it...)
    * GH-276
    * Reported by Mamoru TASAKA

### Thanks

  * Mamoru TASAKA

## 3.6.5 - 2024-12-15 {#version-3-6-5}

### Fixes

  * parallel: thread: Fixed a bug that we can't use `pend` and `notify`.
    * GH-271
    * Reported by Takahiro Ueda
    * Patch by Tsutomu Katsube

### Thanks

  * Takahiro Ueda

  * Tsutomu Katsube

## 3.6.4 - 2024-11-28 {#version-3-6-4}

### Improvements

  * Added support for Ruby 3.4.0.

## 3.6.3 - 2024-11-24 {#version-3-6-3}

### Improvements

  * Added support for thread based parallel test running. You can use
    it by the `--parallel=thread` option. You can disable parallel
    test running per test case by defining `parallel_safe?` class
    method that returns `false`.
    * GH-235
    * Patch by Tsutomu Katsube

  * Added the `--n-workers` option.

  * Added the `--[no-]report-slow-tests` option. You can show the top
    5 slow tests with this option.
    * GH-253
    * Patch by Tsutomu Katsube

  * UI: console: Add support for outputting `Exception#cause`.

  * Added support for inspecting `BasicObject`.
    * GH-262.
    * Patch by Yuta Saito

### Thanks

  * Tsutomu Katsube

  * Yuta Saito

## 3.6.2 - 2024-02-16 {#version-3-6-2}

### Improvements

  * UI: console: Add `--gc-stress` option that enables `GC.stress`
    only whie each test is running.

  * Added support for Ruby 3.4 style backtrace.
    [GH-237][https://github.com/test-unit/test-unit/issues/237]
    [Patch by Yusuke Endoh]

### Thanks

  * Yusuke Endoh

## 3.6.1 - 2023-06-25 {#version-3-6-1}

### Improvements

  * collector: load: Improved performance when a large number of test
    files exist.
    [GH-232][https://github.com/test-unit/test-unit/issues/232]
    [Patch by akira yamada]

### Thanks

  * akira yamada

## 3.6.0 - 2023-05-25 {#version-3-6-0}

### Improvements

  * UI: console: Use `--progress-style=fault-only` with non-tty output
    by default.

## 3.5.9 - 2023-05-25 {#version-3-5-9}

### Improvements

  * UI: console: Use `--progress-style=mark` with `--verbose=verbose`
    by default.

## 3.5.8 - 2023-05-12 {#version-3-5-8}

### Improvements

  * doc: Improved document for multi Ractor mode.
    [GH-226][https://github.com/test-unit/test-unit/issues/226]
    [Patch by Luke Gruber]

  * doc: Updated minitest's URL.
    [GH-228][https://github.com/test-unit/test-unit/issues/228]
    [Patch by Koichi ITO]

  * UI: console: Added `--progress-style` option.

  * UI: console: Compacted `--verbose=important-only` output..

  * UI: console: Changed the default output level to `important-only`
      on GitHub Actions.

### Thanks

  * Luke Gruber

  * Koichi ITO

## 3.5.7 - 2022-12-15 {#version-3-5-7}

### Improvements

  * [UI][console]: Changed to use color escape sequence for each line
    instead of each output that may consist with multiple lines.

## 3.5.6 - 2022-12-15 {#version-3-5-6}

### Improvements

  * [UI][console]: Enabled 256 colors output on GitHub Actions by default.

## 3.5.5 - 2022-10-04 {#version-3-5-5}

### Fixes

  * Suppressed a warning.
    [GitHub#219](https://github.com/test-unit/test-unit/issues/219)[Patch by Kenichi Kamiya]

### Thanks

  * Kenichi Kamiya

## 3.5.4 - 2022-10-04 {#version-3-5-4}

### Improvements

  * Don't raise an error on `Test::Unit::TestCase.clone`.
    [GitHub#210](https://github.com/test-unit/test-unit/issues/210)[Reported by David Marchaland]

  * Added support for `BigDeciaml` in `assert_in_delta` family.
    [GitHub#218](https://github.com/test-unit/test-unit/issues/218)[Patch by Kenta Murata]

### Thanks

  * David Marchaland

  * Kenta Murata

## 3.5.3 - 2021-12-20 {#version-3-5-3}

### Improvements

  * Made how to sub test case generation customizable.
    [GitHub#207](https://github.com/test-unit/test-unit/issues/207)[Patch by Akira Matsuda]

### Thanks

  * Akira Matsuda

## 3.5.2 - 2021-12-10 {#version-3-5-2}

### Improvements

  * Required `fileutils` lazy.
    [GitHub#206](https://github.com/test-unit/test-unit/issues/206)[Patch by David Rodríguez]

### Thanks

  * David Rodríguez

## 3.5.1 - 2021-11-08 {#version-3-5-1}

### Fixes

  * Fixed a bug that `keep: true` is ignored when data set is
    generated by block. [Reported by Kenta Murata]

### Thanks

  * Kenta Murata

## 3.5.0 - 2021-10-18 {#version-3-5-0}

### Fixes

  * Fixed a bug that `keep: true` is ignored when the last `data`
    doesn't have `keep: true`.

## 3.4.9 - 2021-10-18 {#version-3-4-9}

### Improvements

  * Added support for labeling each variable values by using `Hash`.

## 3.4.8 - 2021-10-11 {#version-3-4-8}

### Improvements

  * Added support for omitting Ractor tests on Ruby 2.7 or earlier
    automatically.

## 3.4.7 - 2021-09-14 {#version-3-4-7}

### Fixes

  * Suppressed a warning on Ruby 2.
    [GitHub#205](https://github.com/test-unit/test-unit/issues/205)[Patch by Kenichi Kamiya]

### Thanks

  * Kenichi Kamiya

## 3.4.6 - 2021-09-11 {#version-3-4-6}

### Improvements

  * Added support for tests that use Ractor. Use
    `Test::Unit::TestCase.ractor` to declare that these tests use
    Ractor.

  * Added `--debug-on-failure` option.

## 3.4.5 - 2021-09-04 {#version-3-4-5}

### Improvements

  * Added more metadata to gemspec.
    [GitHub#183](https://github.com/test-unit/test-unit/issues/183)[Patch by Kenichi Kamiya]

  * Removed needless files from gem.
    [GitHub#184](https://github.com/test-unit/test-unit/issues/184)[Patch by Kenichi Kamiya]

  * Updated documents.
    [GitHub#191](https://github.com/test-unit/test-unit/issues/191)[GitHub#192](https://github.com/test-unit/test-unit/issues/192)[GitHub#193](https://github.com/test-unit/test-unit/issues/193)[GitHub#199](https://github.com/test-unit/test-unit/issues/199)[GitHub#200](https://github.com/test-unit/test-unit/issues/200)
    [GitHub#201](https://github.com/test-unit/test-unit/issues/201)[Patch by Kenichi Kamiya]

  * Added `assert_nothing_leaked_memory`.

### Fixes

  * Fixed typos in documents.
    [GitHub#189](https://github.com/test-unit/test-unit/issues/189)[GitHub#190](https://github.com/test-unit/test-unit/issues/190)[GitHub#195](https://github.com/test-unit/test-unit/issues/195)[GitHub#197](https://github.com/test-unit/test-unit/issues/197)[Patch by Kenichi Kamiya]

### Thanks

  * Kenichi Kamiya

## 3.4.4 - 2021-06-04 {#version-3-4-4}

### Improvements

  * Renamed `assert_all?` to `assert_all`. `assert_all?` is deprecated
    but is available.

## 3.4.3 - 2021-06-04 {#version-3-4-3}

### Improvements

  * Stopped to change result value of `Test::Unit::TestCase#include`.

  * Added `assert_all?`.

  * Added support for `assert_raise_with_message`.

## 3.4.2 - 2021-05-30 {#version-3-4-2}

### Improvements

  * [UI][console]: Improved diff readability for no color
    case. Character based diff marks are always showed.

## 3.4.1 - 2021-04-19 {#version-3-4-1}

### Fixes

  * Fixed a bug that `setup`/`cleanup`/`teardown` with block may be
    overwritten by another `setup`/`cleanup`/`teardown` with
    block. It's caused only with Ruby 2.6 or earlier.
    [GitHub#179](https://github.com/test-unit/test-unit/issues/179)[Reported by akira yamada]

### Thanks

  * akira yamada

## 3.4.0 - 2021-01-30 {#version-3-4-0}

### Improvements

  * Enable deprecated warnings by default.

## 3.3.9 - 2020-12-29 {#version-3-3-9}

### Improvements

  * `assert_not_match`: Add support for `String` as pattern.
    [GitHub#178](https://github.com/test-unit/test-unit/issues/178)[Patch by David Rodríguez]

### Thanks

  * David Rodríguez

## 3.3.8 - 2020-12-25 {#version-3-3-8}

### Improvements

  * [UI][console]: Removed reverse mode because Ruby 3.0 reverts
    reverse backtrace.

## 3.3.7 - 2020-11-18 {#version-3-3-7}

### Improvements

  * Improved TruffleRuby support.
    [GitHub#171](https://github.com/test-unit/test-unit/issues/171)[Reported by Benoit Daloze]

  * Removed needless `to_sym`.
    [GitHub#177](https://github.com/test-unit/test-unit/issues/177)[Patch by icm7216]

  * `assert_raise`: Added backtrace for actual error.

  * Improved terminal color availability detection.
    [GitHub#175](https://github.com/test-unit/test-unit/issues/175)[Patch by nicholas a. evans]

  * Changed license to the new Ruby's.
    [GitHub#174](https://github.com/test-unit/test-unit/issues/174)

### Fixes

  * Fixed a typo in `--help` output:
    [GitHub#176](https://github.com/test-unit/test-unit/issues/176)[Patch by icm7216]

### Thanks

  * Benoit Daloze

  * icm7216

  * nicholas a. evans

## 3.3.6 - 2020-06-10 {#version-3-3-6}

### Improvements

  * `name`, `--ignore-name`:

     * Added support for regular expression options.

     * Added support for matching with class name in exact match mode.
       [Reported by Jun Aruga]

  * Updated ruby-talk mailing list information
    [GitHub#168](https://github.com/test-unit/test-unit/issues/168)[Patch by Chris Kampmeier]

### Thanks

  * Chris Kampmeier

  * Jun Aruga

## 3.3.5 - 2020-01-10 {#version-3-3-5}

### Improvements

  * Improved code snippet showing with different default external encoding.
    [GitHub#166](https://github.com/test-unit/test-unit/issues/166)[Patch by Yuta Iwama]

### Thanks

  * Yuta Iwama

## 3.3.4 - 2019-09-30 {#version-3-3-4}

### Improvements

  * Converted markup format to Markdown from RDoc.
    [GitHub#164](https://github.com/test-unit/test-unit/issues/164)[Patch by OGAWA KenIchi]

  * test: Stopped to depend on `Time#inspect` format.
    [GitHub#165](https://github.com/test-unit/test-unit/issues/165)[Reported by Benoit Daloze]

### Thanks

  * OGAWA KenIchi

  * Benoit Daloze

## 3.3.3 - 2019-05-10 {#version-3-3-3}

### Fixed

  * Fixed a bug that priority mode with test case name that uses
    special characters such as `?` can't be used on Windows.

## 3.3.2 - 2019-04-11 {#version-3-3-2}

### Fixes

  * Fixed a bug that `Test::Unit::Collector::Load` doesn't load test
    files under sub directories when these files have the same base
    name as test files in upper directories.
    [Reported by Kenta Murata]

### Thanks

  * Kenta Murata

## 3.3.1 - 2019-03-27 {#version-3-3-1}

### Improvements

  * Added support for `Test::Unit::AssertionFailedError#user_message`
    for not only `assert_equal` and `assert_raise` but also all
    assertions.
    [GitHub#162](https://github.com/test-unit/test-unit/issues/162)[Reported by xgraffm]

### Thanks

  * xgraffm

## 3.3.0 - 2019-01-23 {#version-3-3-0}

### Improvements

  * Added support for auto test run when all tests are defined in
    modules.

  * Added support for defining methods to test case class in multiple
    threads.
    [GitHub#159](https://github.com/test-unit/test-unit/issues/159)[Reported by Charles Oliver Nutter]

  * Suppressed warnings on Ruby 2.5.
    [GitHub#160](https://github.com/test-unit/test-unit/issues/160)[Reported by Daniel Berger]

  * Suppressed warnings on Ruby 2.7.

### Fixes

  * Fixed a code snippet fetch failure when source code isn't UTF-8
    and the default external encoding is set to not UTF-8.
    [GitHub#161](https://github.com/test-unit/test-unit/issues/161)[Reported by masa kunikata]

### Thanks

  * Charles Oliver Nutter

  * Daniel Berger

  * masa kunikata

## 3.2.9 - 2018-12-01 {#version-3-2-9}

### Improvements

  * Added support for data generation by method. `data_#{test_name}`
    is called to generate data for `test_name` test.

  * Added support for data matrix generation.

    Example:

    ```ruby
    data(:a, [0, 1, 2])
    data(:b, [:x, :y])
    def test_data(data)
    end
    ```

    This example generates the following data matrix:

      * label: `"a: 0, b: :x"`, data: `{a: 0, b: :x}`
      * label: `"a: 0, b: :y"`, data: `{a: 0, b: :y}`
      * label: `"a: 1, b: :x"`, data: `{a: 1, b: :x}`
      * label: `"a: 1, b: :y"`, data: `{a: 1, b: :y}`
      * label: `"a: 2, b: :x"`, data: `{a: 2, b: :x}`
      * label: `"a: 2, b: :y"`, data: `{a: 2, b: :y}`

  * Added `Test::Unit::TestCase#data` that returns the current data.

  * Added support for using test method that doesn't have no
    parameters as data driven test.

    Example:

    ```ruby
    data("label", :value)
    def test_data # Available since this release
      p data # :value
    end
    ```

  * Added support for `:keep` option to `Test::Unit::TestCase.data`.

  * Added support for `:group` option to
    `Test::Unit::TestCase.data`. It's useful to generate multiple data
    matrix groups.

    ```ruby
    # Group1
    data(:a, [0, 1, 2], group: :g1)
    data(:b, [:x, :y], group: :g1)
    # Group2
    data(:a, [:x, :y], group: :g2)
    data(:c, [-1, -2], group: :g2)
    def test_data(data)
    end
    ```

    This example generates the following data matrix:

      * label: `"group: :g1, a: 0, b: :x"`, data: `{a: 0, b: :x}`
      * label: `"group: :g1, a: 0, b: :y"`, data: `{a: 0, b: :y}`
      * label: `"group: :g1, a: 1, b: :x"`, data: `{a: 1, b: :x}`
      * label: `"group: :g1, a: 1, b: :y"`, data: `{a: 1, b: :y}`
      * label: `"group: :g1, a: 2, b: :x"`, data: `{a: 2, b: :x}`
      * label: `"group: :g1, a: 2, b: :y"`, data: `{a: 2, b: :y}`
      * label: `"group: :g2, a: :x, b: -1"`, data: `{a: :x, b: -1}`
      * label: `"group: :g2, a: :x, b: -2"`, data: `{a: :x, b: -2}`
      * label: `"group: :g2, a: :y, b: -1"`, data: `{a: :y, b: -1}`
      * label: `"group: :g2, a: :y, b: -2"`, data: `{a: :y, b: -2}`

## 3.2.8 - 2018-05-13 {#version-3-2-8}

### Improvements

  * [UI][console]: Changed to put code snippet before backtrace on
    reverse mode.

## 3.2.7 - 2017-12-12 {#version-3-2-7}

### Improvements

  * Added source code link to gemspec.
    [GitHub#157](https://github.com/test-unit/test-unit/issues/157)[Patch by Grey Baker]

  * Changed to use SVG image for badges in README.
    [GitHub#158](https://github.com/test-unit/test-unit/issues/158)[Patch by Olle Jonsson]

  * [UI][console]: Added `--reverse-output` option to output fault
    details in reverse like Ruby 2.5. It's enabled by default only for
    tty output.

### Fixes

  * Fixed a typo.
    [GitHub#156](https://github.com/test-unit/test-unit/issues/156)[Patch by masa kunikata]

  * [UI][console]: Fixed a bug that broken align in verbose mode.

### Thanks

  * masa kunikata

  * Grey Baker

  * Olle Jonsson

## 3.2.6 - 2017-09-21 {#version-3-2-6}

### Improvements

  * Changed test file require failure to error from omission.
    [GitHub#154](https://github.com/test-unit/test-unit/issues/154)[Patch by naofumi-fujii]

### Thanks

  * naofumi-fujii

## 3.2.5 - 2017-06-24 {#version-3-2-5}

### Improvements

  * Supported `--enable-frozen-string-literal` `ruby` option.
    [GitHub#149](https://github.com/test-unit/test-unit/issues/149)[Reported by Pat Allan]

### Thanks

  * Pat Allan

## 3.2.4 - 2017-05-23 {#version-3-2-4}

### Improvements

  * Updated tests for Ruby 2.4. [GitHUb#136][Patch by Kazuki Tsujimoto]

  * Supported power\_assert 1.0.0. [GitHub#137](https://github.com/test-unit/test-unit/issues/137)[Patch by Kazuki Tsujimoto]

  * Added the getting started document.
    [GitHub#139](https://github.com/test-unit/test-unit/issues/139)[GitHub#141](https://github.com/test-unit/test-unit/issues/141)[Patch by Hiroyuki Sato]

  * Added the document for `attribute`.
    [GitHub#143](https://github.com/test-unit/test-unit/issues/143)[Patch by Fumiaki MATSUSHIMA]

  * Improved a link for GitHub. [GitHub#144](https://github.com/test-unit/test-unit/issues/144)[Patch by rochefort]

  * Updated `.travis.yml`. [GitHub#145](https://github.com/test-unit/test-unit/issues/145)[Patch by Jun Aruga]

### Fixes

  * Fixed a contributor name. [GitHub#131](https://github.com/test-unit/test-unit/issues/131)[Patch by Akira Matsuda]

  * Fixed typos in document. [GitHub#132](https://github.com/test-unit/test-unit/issues/132)[Patch by Akira Matsuda]

  * Fixed typos in document. [GitHub#134](https://github.com/test-unit/test-unit/issues/134)[Patch by Yuji Yaginuma]

  * Fixed a bug that data label with "(" isn't supported.
    [GitHub#135](https://github.com/test-unit/test-unit/issues/135)[Reported by Kazuki Tsujimoto]

  * Fixed assertion message in English.
    [GitHub#133](https://github.com/test-unit/test-unit/issues/133)[Reported by Khalil Fazal]

  * Fixed a typo in typo fix. [GitHub#138](https://github.com/test-unit/test-unit/issues/138)[Patch by kami]

  * Fixed a bug that target location finder may return wrong
    location. [GitHub#146](https://github.com/test-unit/test-unit/issues/146)[Patch by Yuki Ito]

  * Fixed a bug that `--no-show-detail-immediately` raises an error.
    [GitHub#147](https://github.com/test-unit/test-unit/issues/147)[Reported by MSP-Greg]

### Thanks

  * Akira Matsuda

  * Yuji Yaginuma

  * Kazuki Tsujimoto

  * Khalil Fazal

  * kami

  * Hiroyuki Sato

  * Fumiaki MATSUSHIMA

  * rochefort

  * Jun Aruga

  * Yuki Ito

  * MSP-Greg

## 3.2.3 - 2016-11-25 {#version-3-2-3}

### Fixes

  * Fixed a bug that `--order` isn't applied.
    [GitHub#129](https://github.com/test-unit/test-unit/issues/129)[Reported by Vít Ondruch]

### Thanks

  * Vít Ondruch

## 3.2.2 - 2016-11-02 {#version-3-2-2}

### Improvements

  * Improved Travis CI configuration.
    [GitHub#123](https://github.com/test-unit/test-unit/issues/123)[Patch by Ryunosuke Sato]

  * Supported Java native exception.
    [GitHub#126](https://github.com/test-unit/test-unit/issues/126)[Reported by Bob Saveland]

### Fixes

  * doc: Fixed markup. [GitHub#127](https://github.com/test-unit/test-unit/issues/127)[Patch by Tomohiro Hashidate]

  * Fixed a bug that `--location=LINE` may not detect a test when
    fixtures are defined before any tests:

        1 class MyTestCase < Test::Unit::TestCase
        2   setup do
        3   end
        4
        5   test "xxx" do
        6   end
        7 end

    `--location=5` couldn't find the `xxx` test.

    [Reported by Ryota Sasabe]

### Thanks

  * Ryunosuke Sato

  * Tomohiro Hashidate

  * Bob Saveland

  * Ryota Sasabe

## 3.2.1 - 2016-07-19 {#version-3-2-1}

### Improvements

  * Clarified lib/test/unit/diff.rb license. It's a triple license of
    the Ruby license, PSF license and LGPLv2.1 or later.
    [Reported by Luisa Pace]

  * Reported norification when data driven test doesn't have
    parameter.
    [GitHub#122](https://github.com/test-unit/test-unit/issues/122)[Reported by Satoshi "Moris" Tagomori]

### Thanks

  * Luisa Pace

  * Satoshi "Moris" Tagomori

## 3.2.0 - 2016-06-12 {#version-3-2-0}

### Improvements

  * Supported rxvt family terminals as color available terminals.
    [GitHub#121](https://github.com/test-unit/test-unit/issues/121)[Reported by Ippei Kishida]

### Thanks

  * Ippei Kishida

## 3.1.9 - 2016-05-20 {#version-3-1-9}

### Fixes

  * Fixed conflict with test-unit-power_assert.
    [GitHub#120](https://github.com/test-unit/test-unit/issues/120)[Patch by Kazuki Tsujimoto]

  * Fixed a bug that path in `$LOAD_PATH` may be removed.

### Thanks

  * Kazuki Tsujimoto

## 3.1.8 - 2016-03-19 {#version-3-1-8}

### Improvements

  * Added `--stop-on-failure` command line option. With this option,
    running test suite is stopped immediately when one test is failed
    or an error is raised in one test.

## 3.1.7 - 2016-01-17 {#version-3-1-7}

### Fixes

 * Added a missing require.

## 3.1.6 - 2016-01-17 {#version-3-1-6}

It's a Ruby on Rails integration improvement release.

### Improvements

  * Filtered backtrace of power\_assert.
    [GitHub#114](https://github.com/test-unit/test-unit/issues/114)
  * Improved performance to retrieve test defined location.
  * Improved performance to run fixtures in a test.
  * Supported running a test by `yield` in `setup`:

    Before:

        def setup
          @file = File.open("x")
        end

        def teardown
          @file.close
        end

    After:

        def setup
          File.open("x") do |file|
            @file = file
            yield
          end
        end

  * Added `--default-test-path` option that specifies the default path
    that has tests.
  * Made auto runner registration more lazily. Auto runner isn't
    registered automatically until user defines a test. In the
    previous releases, auto runner is registered automatically when
    user defines a test case.
  * Supported specifying a test by location in command line. For
    example, the following command line runs a test that is defined in
    /tmp/test_a.rb at line 10:

        % ruby -r test-unit -e run_test /tmp/test_a.rb:10

### Fixes

  * Fixed a bug that test isn't ran. The test has the same name as
    data driven test that is defined in parent test case.
    [GitHub#115](https://github.com/test-unit/test-unit/issues/115)

## 3.1.5 - 2015-10-09 {#version-3-1-5}

It's a Rack integration improvement release.

### Improvements

  * Renamed experimental top-level `run` method to `run_test` method
    because `run` is conflicted with Rack.
    [GitHub#32](https://github.com/test-unit/test-unit/issues/32)[GitHub:basecamp/pow#303] [Reported by Yevhen Viktorov]

### Thanks

  * Yevhen Viktorov

## 3.1.4 - 2015-09-26 {#version-3-1-4}

It's a minor improvement release.

### Improvements

  * Updated sample code. [GitHub#109](https://github.com/test-unit/test-unit/issues/109)[Patch by takiy33]
  * Updated .travis.yml. [GitHub#110](https://github.com/test-unit/test-unit/issues/110)[Patch by takiy33]
  * document: Added table header in how to document.
    [GitHub#111](https://github.com/test-unit/test-unit/issues/111)[Patch by takiy33]
  * Removed duplicated code.
    [GitHub#112](https://github.com/test-unit/test-unit/issues/112)[Patch by takiy33]
  * Removed needless encoding conversion in fetching code snippet.
    [GitHub#113](https://github.com/test-unit/test-unit/issues/113)[Patch by NARUSE, Yui]

### Thanks

  * takiy33
  * NARUSE, Yui

## 3.1.3 - 2015-07-26 {#version-3-1-3}

It's a bug fix release.

### Improvements

  * Removed unused `TODO` file. [GitHub#108](https://github.com/test-unit/test-unit/issues/108)[Patch by takiy33]

### Fixes

  * `--location`: Fixed a bug that `--location LINE` doesn't work when
    test script is specified as relative path. [Reported by TOMITA Masahiro]

    The following doesn't work:

        % ruby ./test.rb --location 10

    The following works:

        % ruby test.rb --location 10

### Thanks

  * takiy33
  * TOMITA Masahiro

## 3.1.2 - 2015-06-09 {#version-3-1-2}

It's command line option improvements fix release.

### Improvements

  * `--location`: Made path match rule more strict.
    [Suggested by kimura wataru]
    * Before:
      * If test defined path ends with the specified path, the test is
        matched.
    * After:
      * If base name of test defined path equals to the specified
        path, the test is matched.
      * If relative path of test defined path equals to the specified
        path, the test is matched.
      * If the specified path is absolute path and test defined path
        equals to the specified path, the test is matched.
  * `--pattern`: If the option is specified, the default patterns
    aren't used. In the earlier versions, both the default patterns
    and the specified patterns are used.
    [Suggested by kimura wataru]

### Thanks

  * kimura wataru

## 3.1.1 - 2015-05-29 {#version-3-1-1}

It's a bug fix release.

### Fixes

  * Fixed a bug that `--location` detects tests not only in sub test
    case but also parent test case.
    [GitHub#105](https://github.com/test-unit/test-unit/issues/105)[Reported by wanabe]

### Thanks

  * wanabe

## 3.1.0 - 2015-05-28 {#version-3-1-0}

It's a bug fix release.

### Improvements

  * [ui][console] Removed needless new line.

### Fixes

  * Fixed a bug that priority mode can't be used on Windows.
    [GitHub#95](https://github.com/test-unit/test-unit/issues/95)[Reported by Daniel Berger]
  * Fixed a homepage URL RubyGems spec.
    [GitHub#96](https://github.com/test-unit/test-unit/issues/96)[Patch by Masayoshi Takahashi]
    supported.) [GitHub#89](https://github.com/test-unit/test-unit/issues/89)[Patch by Aaron Stone]
  * Fixed a bug that shutdown hook isn't called when pass throw
    exception such as `Interrupt` is raised.
    [GitHub#98](https://github.com/test-unit/test-unit/issues/98)[Reported by jeremiahishere.]
  * Fixed typos in documents.
    [GitHub#100](https://github.com/test-unit/test-unit/issues/100)[Reported by scivola]
    [GitHub#102](https://github.com/test-unit/test-unit/issues/102)[GitHub#103](https://github.com/test-unit/test-unit/issues/103)[Patch by Masafumi Yokoyama]
  * Fixed a bug that the same name test isn't executed in sub test case.
    [GitHub#104](https://github.com/test-unit/test-unit/issues/104)[Reported by wanabe]

### Thanks

  * Daniel Berger
  * Masayoshi Takahashi
  * jeremiahishere
  * scivola
  * Masafumi Yokoyama
  * wanabe

## 3.0.9 - 2014-12-31 {#version-3-0-9}

It's a release that improves colors.

### Improvements

  * Added a work around for Ruby 1.8. (Note: Ruby 1.8 isn't
    supported.) [GitHub#89](https://github.com/test-unit/test-unit/issues/89)[Patch by Aaron Stone]
  * Supported colorized output on Windows.
    [GitHub#90](https://github.com/test-unit/test-unit/issues/90)[Patch by usa]
  * Improved colorized output.
    http://www.a-k-r.org/d/2014-12.html#a2014_12_27_1
    [Suggested by Tanaka Akira]

### Thanks

  * Aaron Stone
  * usa
  * Tanaka Akira

## 3.0.8 - 2014-12-12 {#version-3-0-8}

It's a release that supports Ruby 2.2.0 preview2.

### Improvements

  * Added a link for YARD in README.
    [GitHub:test-unit.github.io#2][Reported by sunnyone]
  * Added description about "/PATTERN/" style value in auto runner usage.
    [GitHub#86](https://github.com/test-unit/test-unit/issues/86)[Suggested by sunnyone]
  * Supported Ruby 2.2.0 preview2 in `assert_throw` and
    `assert_nothing_thrown`.

### Fixes

  * Fixed a bug that error report is failed when source encoding and
    locale encoding are different.
    [GitHub#87](https://github.com/test-unit/test-unit/issues/87)[Reported by scivola]

### Thanks

  * sunnyone
  * scivola

## 3.0.7 - 2014-11-14 {#version-3-0-7}

It's a minor update release.

### Fixes

  * Fixed a bug that teardown blocks aren't called with sub class to
    parent class order.
    [GitHub#85](https://github.com/test-unit/test-unit/issues/85)[Reported by TOMITA Masahiro]

### Thanks

  * TOMITA Masahiro

## 3.0.6 - 2014-11-09 {#version-3-0-6}

It's a minor update release.

### Improvements

  * Improved code snippet location.
    [GitHub#84](https://github.com/test-unit/test-unit/issues/84)[Patch by Yuki Kurihara]

### Thanks

  * Yuki Kurihara

## 3.0.5 - 2014-11-08 {#version-3-0-5}

It's a minor update release.

### Fixes

  * Fixed a bug that startup/shutdown of parent test case isn't called
    when the test case includes one or more modules.
    [GitHub#83](https://github.com/test-unit/test-unit/issues/83)[Reported by Chadderton Odwazny]

### Thanks

  * Chadderton Odwazny

## 3.0.4 - 2014-11-01 {#version-3-0-4}

It's a minor update release.

### Improvements

  * Stopped to remove JRuby and Rubinius internal backtrace entries from
    backtrace on failure/error.
    [GitHub#82](https://github.com/test-unit/test-unit/issues/82)[Patch by Charles Oliver Nutter]

### Thanks

  * Charles Oliver Nutter

## 3.0.3 - 2014-10-29 {#version-3-0-3}

It's a minor update release.

### Improvements

  * Improved `Test::Unit::TestCase.test` performance.
    100 times faster.
  * Supported `Proc` for user message.
    [Sugested by Nobuyoshi Nakada]

### Fixes

  * Fixed markup in document.
    [GitHub#81](https://github.com/test-unit/test-unit/issues/81)[Patch by Masafumi Yokoyama]

### Thanks

  * Masafumi Yokoyama
  * Nobuyoshi Nakada

## 3.0.2 - 2014-10-15 {#version-3-0-2}

It's a minor update release.

### Improvements

  * Supported broken `==` implementation.
    `==` implementation should be fixed but it's not work of test-unit. :<
    [GitHub#71](https://github.com/test-unit/test-unit/issues/71)[Reported by Emily]
  * [UI][console]: Accepted no message failure.
    [GitHub#66](https://github.com/test-unit/test-unit/issues/66)[Reported by Brian Tatnall]
  * Updated gem description.
    [GitHub#74](https://github.com/test-unit/test-unit/issues/74)[Patch by Vít Ondruch]
  * Updated GPL text.
    [GitHub#78](https://github.com/test-unit/test-unit/issues/78)[Patch by Vít Ondruch]

### Fixes

  * Removed needless executable bit from README file.
    [GitHub#79](https://github.com/test-unit/test-unit/issues/79)[Patch by Vít Ondruch]

### Thanks

  * Emily
  * Brian Tatnall
  * Vít Ondruch

## 3.0.1 - 2014-08-05 {#version-3-0-1}

It's a minor update release.

### Improvements

  * Improved Ruby 1.8.7 support. Note that we don't support Ruby 1.8.7
    actively. We just support if its support is painless.
    [GitHub#71](https://github.com/test-unit/test-unit/issues/71)[Patch by estolfo]

### Thanks

  * estolfo

## 3.0.0 - 2014-08-03 {#version-3-0-0}

It's Power Assert supported release!

### Improvements

  * Improved Rubinius support. [Ryo Onodera]
  * Updated RR repository link. [GitHub#56](https://github.com/test-unit/test-unit/issues/56)[Patch by Kenichi Kamiya]
  * Added some minitest compatible assertions. We don't recommend
    using these assertions. They are just for migrating from minitest.
    [GitHub#57](https://github.com/test-unit/test-unit/issues/57)[Patch by Karol Bucek]
    * {Test::Unit::Assertions#refute}
    * {Test::Unit::Assertions#refute_predicate}
    * {Test::Unit::Assertions#refute_empty}
    * {Test::Unit::Assertions#assert_not_includes}
    * {Test::Unit::Assertions#refute_includes}
    * {Test::Unit::Assertions#assert_not_instance_of}
    * {Test::Unit::Assertions#refute_instance_of}
    * {Test::Unit::Assertions#assert_not_kind_of}
    * {Test::Unit::Assertions#refute_kind_of}
    * {Test::Unit::Assertions#assert_not_operator}
    * {Test::Unit::Assertions#refute_operator}
  * Improved code readability. [Suggested by Kenichi Kamiya]
  * Made license field in RubyGems parseable.
    [GitHub#60](https://github.com/test-unit/test-unit/issues/60)[Patch by Michael Grosser]
  * Improved test case match feature by `--testcase` and `--ignore-testcase`
    options. They also checks parent class names.
  * Made inspected representation of Numeric objects especially
    BigDecimal more readable. [GitHub#64](https://github.com/test-unit/test-unit/issues/64)[Reported by Byron Appelt]
  * Added badges for Traivs CI and RubyGems.
    [GitHub#65](https://github.com/test-unit/test-unit/issues/65)[Patch by Byron Appelt]
  * Supported Power Assert. You can use Power Assert with
    {Test::Unit::Assertions#assert} with block. See method document
    for details. We recommend using Power Assert for predicate method
    checks. For example, we recommend Power Assert rather than
    {Test::Unit::Assertions#assert_true},
    {Test::Unit::Assertions#assert_predicate} and so on. We don't
    recommend using Power Assert for equality check assertion.
    {Test::Unit::Assertions#assert_equal} should be used for the case.
    [Kazuki Tsujimoto]

### Fixes

  * Fixed a bug that test case defined by block has wrong location.
    [GitHub#58](https://github.com/test-unit/test-unit/issues/58)[Patch by Narihiro Nakamura]
  * Fixed a bug that test methods defined in included modules in
    super-class are also collected.
    [GitHub#62](https://github.com/test-unit/test-unit/issues/62)[GitHub#63](https://github.com/test-unit/test-unit/issues/63)[Patch by Karol Bucek]

### Thanks

  * Ryo Onodera
  * Kenichi Kamiya
  * Karol Bucek
  * Narihiro Nakamura
  * Michael Grosser
  * Byron Appelt
  * Kazuki Tsujimoto

## 2.5.5 - 2013-05-18 {#version-2-5-5}

It's Ruby 2.0.0 supported release!

### Improvements

  * Supported Ruby 2.0.0. [GitHub#54](https://github.com/test-unit/test-unit/issues/54) [Reported by mtasaka]
  * Accepted screen-256color TERM as 256 colors available environment.
    [GitHub#55](https://github.com/test-unit/test-unit/issues/55) [Reported by Tom Miller]

### Fixes

  * Fixed a typo in document.
    [GitHub#53](https://github.com/test-unit/test-unit/issues/53) [Patch by Baptiste Fontaine]
  * Fixed a bug in {Test::Unit::Assertions#assert_in_epsilon}. It doesn't work
    as expected if expected value is negative value.
    [Ruby Bug #8317] [Reported by Nobuhiro IMAI]

### Thanks

  * Baptiste Fontaine
  * mtasaka
  * Tom Miller
  * Nobuhiro IMAI

## 2.5.4 - 2013-01-23 {#version-2-5-4}

It's a bug fix release.

### Improvements

  * Added documents for data driven test functionality.
  * Added TSV support for data driven test functionality.
  * Support tag inspection on JRuby.

### Fixes

  * Fixed a bug. It is too slow to filter tests when there are many
    tests. [GitHub#46](https://github.com/test-unit/test-unit/issues/46)
  * Accept anonymous test suite.
    [GitHub:#49] [Reported by Matthew Rudy Jacobs]

### Thanks

  * Matthew Rudy Jacobs

## 2.5.3 - 2012-11-28 {#version-2-5-3}

It's a release for minitest compatibility and bug fix.

### Improvements

  * Supported diff in invalid encoding.
  * Added some assersion methods just for minitest compatibility.
    Added methods are assert_includes(), refute_*() and refute().
    If you are test-unit user, please don't use them.
    [GitHub#40](https://github.com/test-unit/test-unit/issues/40) [Suggested by Michael Grosser]
  * Added --attribute option to select target tests by attribute.
    [test-unit-users-en:00098] [Suggested by Piotr Nestorow]

### Fixes

  * Allowed use of test for inheritance in ActionController::TestCase.
    [GitHub#42](https://github.com/test-unit/test-unit/issues/42) [Patch by David Rasch]
  * Ensured evaluating at_exit block in top level.
    In IRB context, exit() specifies irb_exit().
    [test-unit-users-en:00089] [Reported by Daniel Berger]
  * Fixed a bug that decoration style description is ignored.
    "decoration style description" are using description method
    above "def test_name" or with Symbol specifying test_name.
    [GitHub#45](https://github.com/test-unit/test-unit/issues/45) [Reported by Piotr Nestorow]

### Thanks

  * Michael Grosser
  * David Rasch
  * Daniel Berger
  * Piotr Nestorow

## 2.5.2 - 2012-08-29 {#version-2-5-2}

It's an improvement release for tmtms. `--location` is a similar
feature to `--line_number` in RSpec. `sub_test_case` is a similar
feature to `context` in shoulda-context and RSpec.

### Improvements

  * Cleaned up tests.
    [GitHub#34](https://github.com/test-unit/test-unit/issues/34) [Patch by Michael Grosser]
  * Added missing background color for 8 color environment.
  * Added workaround for NetBeans.
    [GitHub#38](https://github.com/test-unit/test-unit/issues/38) [Reported by Marc Cooper]
  * Added `--location` command line option that selects target tests
    by test defined location.
  * Created sub test suite for each subclassed test case.
  * [ui][console] Supported nested test suites.
  * Added {Test::Unit.at_start} and {Test::Unit.at_exit} hooks that
    are run before/after all tests are run.
    [Good hook name is suggested by kdmsnr]
  * Improved code snippet target on failure. Test method is always used
    for code snippet target.
    [GitHub#39](https://github.com/test-unit/test-unit/issues/39) [Suggested by Michael Grosser]
  * Added {Test::Unit::TestCase.sub_test_case} that creates sub test case.
    The sub test case name isn't limited Ruby's constant name rule. You can
    specify the sub test case name in free form.

### Thanks

  * Michael Grosser
  * Marc Cooper
  * kdmsnr

## 2.5.1 - 2012-07-05 {#version-2-5-1}

It's a bug fix release.

### Improvements

  * Supported installing from GitHub.
    [GitHub#29](https://github.com/test-unit/test-unit/issues/29) [Suggested by Michael Grosser]
  * Supported ActiveSupport::TestCase.
    [GitHub#30](https://github.com/test-unit/test-unit/issues/30) [Reported by Michael Grosser]
  * [ui][console] Improved multiline falut message display.

### Fixes

  * [ui][console] Fixed a bug that expected and actual values are
    empty.
    [GitHub#31](https://github.com/test-unit/test-unit/issues/31)[GitHub#33](https://github.com/test-unit/test-unit/issues/33)
    [Reported by Kendall Buchanan][Reported by Mathieu Martin]
    [Hinted by Michael Grosser]
  * Fixed a bug that .gemspec can't be loaded on LANG=C.
    [RubyForge#29595] [Reported by Jean-Denis Koeck]

### Thanks

  * Michael Grosser
  * Kendall Buchanan
  * Mathieu Martin
  * Jean-Denis Koeck

## 2.5.0 - 2012-06-06 {#version-2-5-0}

It's a bug fix release.

### Fixes

  * Fixed a backward incompatibility of `TestUnitMediator#run_suite`
    introduced in 2.4.9.
    [GitHub#28](https://github.com/test-unit/test-unit/issues/28) [Reported by Vladislav Rassokhin]

### Thanks

  * Vladislav Rassokhin

## 2.4.9 - 2012-06-03 {#version-2-4-9}

It's a bug fix release.

### Improvements

  * `Test::Unit.run?` ->
    `Test::Unit::AutoRunner.need_auto_run?`. `Test::Unit.run?` is marked
    as deprecated but it is still available.
  * [experimental] Added top level "run" method for `"ruby -rtest-unit -e
    run test/test_*.rb"`. Is this API OK or dirty?
  * Made failure output more readable on no color mode.
  * Supported showing ASCII-8BIT diff in failure message.
  * [ui][console] Supported `ENV["TERM"] == "xterm-256color"` as color
    available terminal.
    [GitHub#26](https://github.com/test-unit/test-unit/issues/26) [Reported by Michael Grosser]
  * [ui][console] Supported "-256color" suffix `ENV["TERM"]` terminal
    as 256 color supported terminal.

### Fixes

  * Fixed a bug that `--workdir` doesn't work.
  * Consumed processed command line parameters in `ARGV` as `--help`
    says.
    [RubyForge#29554] [Reported by Bob Saveland]
  * Added missing `require "test/unit/diff"`.
    [GitHub#25](https://github.com/test-unit/test-unit/issues/25) [Reported by Stephan Kulow]

### Thanks

  * Bob Saveland
  * Stephan Kulow
  * Michael Grosser

## 2.4.8 - 2012-3-6 {#version-2-4-8}

It's a bug fix release.

### Improvements

  * Delayed at_exit registration until Test::Unit is used.
    [GitHub:#21] [Reported by Jason Lunn]
  * Added workaround for test-spec.
    [GitHub:#22] [Reported by Cédric Boutillier]

### Fixes

  * Fixed an error on code snippet display on JRuby.
    [GitHub:#19][GitHub:#20]
    [Reported by Jørgen P. Tjernø][Patch by Junegunn Choi]

### Thanks

  * Jørgen P. Tjernø
  * Junegunn Choi
  * Jason Lunn

## 2.4.7 - 2012-2-10 {#version-2-4-7}

It's a code snippet improvement release.

### Improvements

  * Supported code snippet display on all faults.

## 2.4.6 - 2012-2-9 {#version-2-4-6}

It's a TAP runner separated release.

### Improvements

  * Moved TAP runner to test-unit-runner-tap gem from test-unit gem.
  * Supported code snippet display on failure.

## 2.4.5 - 2012-1-16 {#version-2-4-5}

It's a failure message readability improvement release.

### Improvements

  * Removed needless information from exception inspected
    text on failure. It's for easy to read.
  * Supported custom inspector.

## 2.4.4 - 2012-1-2 {#version-2-4-4}

It's a Rails integration improved release.

### Improvements

  * [ui][console] Don't break progress display when a test is failed.
  * [ui][console] Added markers betwen a failure detail
    message in progress to improve visibility.
  * [travis] Dropped Ruby 1.8.6 as a test target. [GitHub:#13]
    [Patch by Josh Kalderimis]
  * Supported expected value == 0 case in assert_in_epsilon. [RubyForge#29485]
    [Reported by Syver Enstad]
  * Supported a block style setup/teardown/cleanup.

### Thanks

  * Josh Kalderimis
  * Syver Enstad

## 2.4.3 - 2011-12-11 {#version-2-4-3}

### Improvements

  * Improved SimpleCov integration by stopping to modify
    `ARGV` in auto runner. [GitHub:#12]
    [Reported by Nikos Dimitrakopoulos]
  * Improved JRuby integration by removing JRuby internal backtrace.

### Thanks

  * Nikos Dimitrakopoulos

## 2.4.2 - 2011-11-26 {#version-2-4-2}

### Improvements

  * `--name` supported data label.

## 2.4.1 - 2011-11-09

### Improvements

  * Accepted AssertionMessage as assertion's user message.
    It is used in assert_select in actionpack.
    [Reported by David Heath]

### Fixes

  * Fixed test failure on LANG=C. #11 [Reported by boutil]
  * Suppress warnings on Ruby 1.9.2.

### Thanks

  * boutil
  * David Heath

## 2.4.0 - 2011-09-18

### Improvements

  * Supported Travis CI. #5 [Suggested by James Mead]
  * Added Gemfile. #6 [Suggested by James Mead]
  * [ui][console] Supported notification in show-detail-immediately.
  * [ui][console] enable --show-detail-immediately by default.
  * [ui] Added --max-diff-target-string-size option.
  * [ui][console] Supported 256 colors.

### Fixes

  * Added missing fixture file. #7 [Reported by grafi-tt]
  * [ui][console] Added missing the last newline for progress level.
  * Supported correct backtrace for redefined notification.
  * Don't handle Timeout::Error as pass through exception on Ruby 1.8. #8
    [Reported by Marc Seeger (Acquia)]

### Thanks

  * James Mead
  * grafi-tt
  * Marc Seeger (Acquia)

## 2.3.2 - 2011-08-15

A bug fix release.

### Improvements

  * [ui][console] Added some newlines to improve readability.

### Fixes

  * [ui][console] Worked --verbose again.
  * Re-supported Ruby 1.8.6. [Reported by James Mead]

### Thanks

  * James Mead

## 2.3.1 - 2011-08-06 {#version-2-3-1}

Output improvement release!

### Improvements

  * [ui][console] Outputs omissions and notifications in short.
  * [ui][console] Added "important-only" verbose level.
  * Intelligence diff supports recursive references.
  * [rubyforge #29325] Supported Ruby Enterprise Edition.
    [Reported by Hans de Graaff]
  * [rubyforge #29326] Supported JRuby.
    [Reported by Hans de Graaff]
  * Added --show-detail-immediately option that shows
    fault details when a fault is occurred.

### Fixes

  * [pull request #1] Fixed a problem that load collector
    can't load a test file on Ruby 1.9. [Patch by grafi-tt]
  * [issue #3] Fixed a problem that implicit method name
    override by declarative style test definition.
    [Reported by Jeremy Stephens]

### Thanks

  * grafi-tt
  * Jeremy Stephens
  * Hans de Graaff

## 2.3.0 / 2011-04-17

* 13 enhancements
  * improve Hash key sorting for diff.
  * [#28928] support any characters in declarative style description.
    [Daniel Berger]
  * add Error#location and make #backtrace deprecated.
  * make TestCase#passed? public.
  * add result finished and pass assertion notifications.
  * add TestSuite#passed? public.
  * add XML test runner.
  * add --output-file-descriptor option.
  * measure elapsed time for each test.
  * add --collector option.
  * support test driven test.
    [Haruka Yoshihara]
  * add cleanup hook it runs between after test and before teardown.
  * support recursive collection sort for diff.

* Thanks
  * Daniel Berger
  * Haruka Yoshihara

## 2.2.0 / 2011-02-14

* 22 enhancements
  * [#28808] accept String as delta for assert_in_delta.
    [Daniel Berger]
  * [test-unit-users-en:00035] make GC-able finished tests.
    [Daniel Berger]
  * use also COLUMNS environment variable to guess terminal width.
  * make delta for assert_in_delta optional.
    [Nobuyoshi Nakada]
  * add assert_not_respond_to.
    [Nobuyoshi Nakada]
  * add assert_not_match. assert_no_match is deprecated.
    [Nobuyoshi Nakada]
  * add assert_not_in_delta.
    [Nobuyoshi Nakada]
  * add assert_in_epsilon.
    [Nobuyoshi Nakada]
  * add assert_not_in_epsilon.
    [Nobuyoshi Nakada]
  * add assert_include.
    [Nobuyoshi Nakada]
  * add assert_not_include.
    [Nobuyoshi Nakada]
  * add assert_empty.
    [Nobuyoshi Nakada]
  * add assert_not_empty.
    [Nobuyoshi Nakada]
  * notify require failed paths.
  * validate message value for assert.
  * show throughputs at the last.
  * support not ASCII compatible string diff.
  * support colorized diff on encoding different string.
  * normalize entry order of Hash for readable diff.
  * add --ignore-name option.
  * add --ignore-testcase option.
  * add assert_not_send.

* Thanks
  * Daniel Berger
  * Nobuyoshi Nakada

## 2.1.2 / 2010-11-25

* 1 enhancement
  * support auto runner prepare hook.

## 2.1.1 / 2010-07-29

* 1 bug fix
  * [test-unit-users-en:00026] re-work tap runner.
    [Daniel Berger]

* Thanks
  * Daniel Berger

=== 2.1.0 / 2010-07-17

* 1 bug fix
  * [#28267] global config file ignored
    [Daniel Berger]

* Thanks
  * Daniel Berger

## 2.0.8 / 2010-06-02

* 5 major enchancements
  * collect *_test.rb and *-test.rb files as test files.
  * [#28181] improve assert_in_delta message.
    [Suggested by David MARCHALAND]
  * show string encoding in assert_equal failure message if
    they are different.
  * change default color scheme:
    * success: green back + white
    * failure: red back + white
  * add capture_output.

* 2 bug fixes
  * fix a bug that console runner on verbose mode causes an
    error for long test name (>= 61).
  * [#28093] Autorunner ignores all files in a directory named test by default
    [Reported by Florian Frank]

* Thanks
  * Florian Frank
  * David MARCHALAND

## 2.0.7 / 2010-03-09

* 4 major enhancements
  * detect redefined test methods.
  * [INTERFACE IMCOMPATIBLE] multiple --name and --testcase
    options narrow down targets instead of adding targets.
  * [#27764] accept custom test_order for each test case.
    [Suggested by David MARCHALAND]
  * [#27790] ignore omitted tests from 'n% passed' report.
    [Suggested by Daniel Berger]

* 2 minor enchancements
  * [#27832] ignore .git directory. [Suggested by Daniel Berger]
  * [#27792] require 'fileutils' and 'tmpdir' lazily for non-priority
    mode users. [Suggested by David MARCHALAND]

* 2 bug fixes
  * [#27892] modify processed arguments array destructively.
    [Reported by Bob Saveland]
  * work without HOME environment variable.
    [Reported by Champak Ch]

* Thanks
  * David MARCHALAND
  * Daniel Berger
  * Bob Saveland
  * Champak Ch

## 2.0.6 / 2010-01-09

* 3 major enhancements
  * [#27380] Declarative syntax? [Daniel Berger]
    support declarative syntax:

      test "test description in natural language" do
         ...
      end
  * support test description:
      description "test description in natural language"
      def test_my_test
         ...
      end
  * make max diff target string size customizable by
    TEST_UNIT_MAX_DIFF_TARGET_STRING_SIZE environment variable.

* 2 bug fixes
  * [#27374] omit_if unexpected behavior [David MARCHALAND]
  * fix a bug that tests in sub directories aren't load with --basedir.
    [Daniel Berger]

* Thanks
  * David MARCHALAND
  * Daniel Berger

## 2.0.5 / 2009-10-18

* 1 bug fixes
  * [#27314] fix diff may raise an exception. [Erik Hollensbe]

* Thanks
  * Erik Hollensbe

## 2.0.4 / 2009-10-17

* 4 major enhancements
  * use ~/.test-unit.yml as global configuration file.
  * add TAP runner. (--runner tap)
  * support colorized diff:
    https://test-unit.github.io/color-diff.png
  * add Test::Unit::AutoRunner.default_runner= to specify default test runner.

* 4 minor enhancements
  * improve verbose mode output format. (use indent)
  * support `NOT_PASS_THROUGH_EXCEPTIONS`.
  * support arguments option in `#{runner}_options`.
  * TC_ -> Test in sample test case name.

* 1 bug fixes
  * [#27195] test-unit-2.0.3 + ruby-1.9.1 cannot properly test
    DelegateClass subclasses [Mike Pomraning]

* Thanks
  * Mike Pomraning

## 2.0.3 / 2009-07-19

* 6 major enhancements
  * add assert_predicate.
  * add assert_not_predicate.
  * [#24210] assert_kind_of supports an array of classes or modules.
    [Daniel Berger]
  * assert_instance_of supports an array of classes or modules.
  * add --default-priority option.
  * [#26627] add --order option. [Daniel Berger]

* 4 minor enhancements
  * use yellow foreground + black background for error.
  * don't show diff for long string.
  * accept "*term-color" TERM environment as colorizable terminal.
    (e.g. Apple's Terminal)
  * [#26268] add a workaround for test-spec's after_all. [Angelo Lakra]

* 1 bug fix
  * [#23586] re-support ruby 1.9.1. [Diego Pettenò]

* Thanks
  * Diego Pettenò
  * Daniel Berger
  * Angelo Lakra

## 2.0.2 / 2008-12-21

* 2 major enhancements

  * re-support ruby 1.8.5.
  * improve exception object comparison.

* 3 bug fixes

  * [#22723]: collector fails on anonymous classes
  * [#22986]: Test names with '?' blow up on Windows
  * [#22988]: don't create .test-result on non-priority mode.

* Thanks

  * Erik Hollensbe
  * Daniel Berger
  * Bill Lear

## 2.0.1 / 2008-11-09

* 19 major enhancements

  * support ruby 1.9.1.
  * add run_test method to be extensible.
  * improve priority-mode auto off.
  * improve startup/shutdown RDoc. [Daniel Berger]
  * add assert_compare. [#20851] [Designing Patterns]
  * add assert_fail_assertion. [#20851] [Designing Patterns]
  * add assert_raise_message. [#20851] [Designing Patterns]
  * support folded diff.
  * add assert_raise_kind_of. [Daniel Berger]
  * ingore inherited test for nested test case.
  * add assert_const_defined.
  * add assert_not_const_defined.
  * support assert_raise with an exception object.
  * support assert_raise with no arguments that asserts any
    exception is raised. [#22602] [Daniel Berger]
  * support folded dot progress.
  * add --progress-row-max option.
  * support color scheme customize.
  * support configuration file. (YAML)
  * recognize test-XXX.rb files as test files not only test_XXX.rb

* Thanks

  * Daniel Berger
  * Designing Patterns

## 2.0.0 / 2008-06-18

* 15 major enhancements

  * support startup/shutdown. (test case level setup/teardown)
  * support multiple setup/teardown.
  * support pending.
  * support omission.
  * support notification.
  * support colorize.
  * support diff.
  * support test attribute.
  * add assert_boolean.
  * add assert_true.
  * add assert_false.
  * add --priority-mode option.
  * don't use ObjectSpace to collect test cases.
  * make more customizable. (additional options, exception handling and so on)
  * improve Emacs integration.

* 4 major changes

  * remove GTK+1 support.
  * split GTK+ runner as another gem.
  * split FOX runner as another gem.
  * split Tk runner as another gem.

## 1.2.3 / 2008-02-25

* 1 major enhancement

  * Birthday (as a gem)!
