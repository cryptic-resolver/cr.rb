# Changelog

## [Unreleased](#) (2023-08-15)

<br>

## [v4.1.8](#) (2023-08-15)

### Bug fixes:

- Fix the path that has spaces when `git clone`

<br>

## [v4.1.7](#) (2023-07-29)

### Deprecations:

- Change default lib location

<br>

## [v4.1.6](#) (2023-05-15)

### Enhancements:

- Rename some internal APIs
- Using `rainbow` rather than `colorator`
- Using `minitest` rather than `test-unit`

<br>

## [v4.1.5](#) (2023-05-09)

### Enhancements:

- Compact not found info
- Refactor lib structure
- Use `colorator` rather than handmade lib

<br>

## [v4.1.4](#) (2023-03-22)

### Bug fixes:

- Fix bug of `-l` list file: [GitHub issue 8](https://github.com/cryptic-resolver/cr.rb/issues/8)

### Deprecations:

- Remove `cryptic_dos` and `cryptic_mechanical` dictionaries

<br>

## [v4.1.3](#) (2023-02-13)

### Bug fixes:

- Fix bug: read unrelated files in dictionary

<br>

## [v4.1.2](#) (2023-02-13)

### Bug fixes:

- Fix bug: `cr -c` counts twice

<br>

## [v4.1.1](#) (2023-02-13)

### Bug fixes:

- Fix `require` error in `lib/cr.rb`

<br>

## [v4.1.0](#) (2023-02-13)

### New features:

- Add new feature dictionary: mruby source code dictionary

### Enhancements:

- Huge refactor

<br>

## [v4.0.3](#) (2023-02-05)

### Enhancements:

- Remove command line see also print trailing space
- Colorize `NOT FOUND` info

### Bug fixes:

- Fix bug of `$cr` help messages, see [commit 5d8399c](https://github.com/cryptic-resolver/cr.rb/commit/5d8399c6a523001478202a90c90c81f76bd694cb)

<br>

## [v4.0.2](#) (2022-11-29)

### Enhancements:

- Use `WARN` to make CI test more accurate

<br>

## [v4.0.1](#) (2022-11-28)

### Bug fixes:

- Fix word count in adding new dict and pulling default dicts

<br>

## [v4.0.0](#) (2022-11-27)

### Enhancements:

- Use new index 0-9.toml
- Use new jump symbol `=>`
- Add support for user config
- List official dicts
- Word count different libraries

### Deprecations:

- Not use old index 0123456789.toml
- Not use old jump symbol `<=>`

<br>

## [v3.21.0](#) (2022-10-30)

### Enhancements:

- Add `cryptic_linux` to default dicts

<br>

## [v3.20.0](#) (2022-10-20)

### Enhancements:

- Update tests
- CI updates all cryptic_xxx dicts words
- `bin/wc` counts all local dicts
- Choose different default dicts

<br>

## [v3.19.0](#) (2022-04-15)

### New features:

- Support see_also can be one word
- Simplify adding dictionary with `user/repo`

<br>

## [v3.18.2](#) (2022-04-15)

### Enhancements:

- Add CI test

### Bug fixes:

- Ensure cr home dir exists when adding new dict

<br>

## [v3.18.0](#) (2022-04-11)

### Deprecations:

- Use `more` rather than `full`
- Use `name` rather than `disp`

<br>

## [v3.17.0](#) (2022-04-11)

### New features:

- Support to show the word's own better name when jumping

### Enhancements:

- Add `cr.rb` gem
- Add tests

<br>

## [v3.16](#) (2022-04-05)

### Enhancements:

- Always add default dicts when help

### Bug fixes:

- Fix error on `cr -u` when first installed, this is because of double word counting
- Fix no dir error when first installed, this is because of the word count of help

<br>

## [v3.15](#) (2022-04-01)

### Bug fixes:

- Fix user dict word count

<br>

## [v3.14](#) (2022-03-24)

### Enhancements:

- Either `desc` or `more` exists is OK

<br>

## [v3.13](#) (2022-03-24)

### New features:

- Allow double or more jumps

<br>

## [v3.12](#) (2022-03-24)

### Enhancements:

- add dependency to print

<br>

## [v3.11](#) (2022-03-22)

### New features:

- Add support to search words via regexp

### Enhancements:

- Add support to jump to dotted word

<br>

## [v3.10](#) (2022-03-18)

### New features:

- Add spaceship delimiter for jump info

### Enhancements:

- Migrate from **github_changelog_generator** to **chlog**
- Yank version `v4,5,6` from RubyGems, release on `v3.x` series

<br>

## [v3.0 - v3.9](#)

### New features:

- Add parallel update and pull support
- Add `-l`, `-d` to manage local dictionaries

### Bug fixes:

- Fix many small bugs

<br>

## [v1.0 - v2.3](#)

### New features:

- Support dotted words [GitHub issue #5](https://github.com/cryptic-resolver/cr/issues/5)
- Warn to incomplete explanation [GitHub issue #4](https://github.com/cryptic-resolver/cr/issues/4)
- Add original keyword to print [GitHub issue #3](https://github.com/cryptic-resolver/cr/issues/3)
- Add 'see' keyword [GitHub issue #2](https://github.com/cryptic-resolver/cr/issues/2)
- Add 'same' keyword  [GitHub issue #1](https://github.com/cryptic-resolver/cr/issues/1)

<br>

## [Initialize](#) (2021-07-08)

<br>

<hr>

This Changelog is maintained with [chlog](https://github.com/ccmywish/chlog)

