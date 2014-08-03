# test-unit

[![](https://badge.fury.io/rb/test-unit.png)](http://badge.fury.io/rb/test-unit)
[![](https://travis-ci.org/test-unit/test-unit.png?branch=master)](https://travis-ci.org/test-unit/test-unit)

* http://test-unit.github.io/
* https://github.com/test-unit/test-unit

## Description

test-unit - Improved version of Test::Unit bundled in Ruby
1.8.x.

Ruby 1.9.x bundles minitest not Test::Unit. Test::Unit
bundled in Ruby 1.8.x had not been improved but unbundled
Test::Unit (test-unit) is improved actively.

## Features

* Test::Unit 1.2.3 is the original Test::Unit, taken
  straight from the ruby distribution. It is being
  distributed as a gem to allow tool builders to use it as a
  stand-alone package. (The test framework in ruby is going
  to radically change very soon).

* test-unit will be improved actively and may break
  compatiblity with Test::Unit 1.2.3. (We will not hope it
  if it isn't needed.)

* Some features exist as separated gems like GUI test
  runner. (Tk, GTK+ and Fox) test-unit-full gem package
  provides for installing all Test::Unit related gems
  easily.

## How To

* {file:doc/text/how-to.textile}

## Install

<pre>
% sudo gem install test-unit
</pre>

If you want to use full Test::Unit features:

<pre>
% sudo gem install test-unit-full
</pre>

## License

(The Ruby License)

This software is distributed under the same terms as ruby.

Exception:

  * lib/test/unit/diff.rb is a double license of the Ruby license and
    PSF license.

  * lib/test-unit.rb is a dual license of the Ruby license and LGPLv2.1
    or later.

## Authors

### Active

* Kouhei Sutou: The current maintainer
* Haruka Yoshihara: Data driven test supports.

### Inactive

* Nathaniel Talbott: The original author
* Ryan Davis: The second maintainer

### Images

* Mayu & Co.: kinotan icons: http://cocooooooon.com/kinotan/

## Thanks

* Daniel Berger: Suggestions and bug reports.
* Designing Patterns: Suggestions.
* Erik Hollensbe: Suggestions and bug reports.
* Bill Lear: A suggestion.
* Diego Pettenò: A bug report.
* Angelo Lakra: A bug report.
* Mike Pomraning: A bug report.
* David MARCHALAND: Suggestions and bug reports.
* Andrew Grimm: A bug report.
* Champak Ch: A bug report.
* Florian Frank: A bug report.
* grafi-tt: Bug fixes and reports.
* Jeremy Stephens: A bug report.
* Hans de Graaff: Bug reports.
* James Mead: A bug report.
* Marc Seeger (Acquia): A bug report.
* boutil: A bug report.
* Vladislav Rassokhin: A bug report.
