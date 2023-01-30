<div align="center">

# Cryptic Resolver
[![Test](https://github.com/cryptic-resolver/cr.rb/workflows/Test-Behavior/badge.svg)](https://github.com/cryptic-resolver/cr.rb/actions/workflows/test.yml)
[![word-count](https://img.shields.io/badge/Keywords%20Inlcuded-1666-brightgreen)](#cryptic-sheets)
[![Gem Version](https://badge.fury.io/rb/cr.rb.svg)](https://rubygems.org/gems/cr.rb) 
[![Gitter](https://badges.gitter.im/cryptic-resolver/community.svg)](https://gitter.im/cryptic-resolver/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

```bash
# Install

$ gem install cr.rb
```

![screenshot](./images/screenshot.png)

</div>


This command line tool `cr` is used to **record and explain cryptic commands, acronyms(initialism), abbreviations and so forth** in daily life.
The effort is to study etymology and know of naming conventions.

Not only can it be used in the computer filed, but also you can use this to manage your own knowledge base easily.

- Currently we have **1666** keywords explained in all of our official ***cryptic_xxx*** dictionaries.

<br>

## Usage

```bash
$ cr emacs
# -> Emacs: Edit macros
# ->
# ->   a feature-rich editor
# ->
# -> SEE ALSO Vim 

$ cr -s pattern
# -> search words matched with pattern

$ cr -u 
# -> update all dictionaries

$ cr -a https://github.com/ccmywish/ruby_knowledge
# -> Add your own knowledge base! 

$ cr -a ccmywish/git_knowledge
# -> Add a user's dict from Github by username and repo 

$ cr -l
# All cryptic-resolver official dicts can be listed (local dicts listed also)

$ cr -a x86
# -> Add official dict 'cryptic-resolver/cryptic_x86', no need to specify the prefix!

$ cr -c
# -> word count

$ cr -h
# -> show help for more operations
```

<br>


## Why?

The aim of this project is to:

1. Make cryptic things clear
2. Help maintain your own personal knowledge base

rather than

- Record the use of a command, for this you can refer to [tldr], [cheat] and so on. 

<br>


<a name="official-dictionaries"></a> 
## Default dictionaries

You can override the default dicts by using a [config file](#config-file).

- [![cryptic_common](https://github.com/cryptic-resolver/cryptic_common/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_common/actions/workflows/test.yml) [cryptic_common]
- [![cryptic_computer](https://github.com/cryptic-resolver/cryptic_computer/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_computer/actions/workflows/test.yml) [cryptic_computer]
- [![cryptic_windows](https://github.com/cryptic-resolver/cryptic_windows/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_windows/actions/workflows/test.yml) [cryptic_windows]
- [![cryptic_linux](https://github.com/cryptic-resolver/cryptic_linux/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_linux/actions/workflows/test.yml) [cryptic_linux]
- [![cryptic_electronics](https://github.com/cryptic-resolver/cryptic_electronics/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_electronics/actions/workflows/test.yml) [cryptic_electronics]

<br>

## Other official dictionaries

```bash
# List all official dicts (and local dicts)
$ cr -l

# Easy to add!
$ cr -a economy

$ cr -a medicine

$ cr -a electronics

...
```

- [![cryptic_economy](https://github.com/cryptic-resolver/cryptic_economy/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_economy/actions/workflows/test.yml) [cryptic_economy]
- [![cryptic_medicine](https://github.com/cryptic-resolver/cryptic_medicine/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_medicine/actions/workflows/test.yml) [cryptic_medicine]
- [![cryptic_science](https://github.com/cryptic-resolver/cryptic_science/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_science/actions/workflows/test.yml) [cryptic_science]
- [![cryptic_mechanical](https://github.com/cryptic-resolver/cryptic_mechanical/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_mechanical/actions/workflows/test.yml) [cryptic_mechanical]
- [![cryptic_math](https://github.com/cryptic-resolver/cryptic_math/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_math/actions/workflows/test.yml) [cryptic_math]

<br>

- [![cryptic_dos](https://github.com/cryptic-resolver/cryptic_dos/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_dos/actions/workflows/test.yml) [cryptic_dos]
- [![cryptic_x86](https://github.com/cryptic-resolver/cryptic_x86/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_x86/actions/workflows/test.yml) [cryptic_x86]
- [![cryptic_signal](https://github.com/cryptic-resolver/cryptic_signal/workflows/Test-Dict/badge.svg)](https://github.com/cryptic-resolver/cryptic_signal/actions/workflows/test.yml) [cryptic_signal]

<br>

## Implementation

`cr` is written in **Ruby**. You can implement this tool in any other language you like (name your projects as `cr_Python` or `cr.py` for example), just remember to reuse [cryptic_computer] and other dictionaries which are the core parts anyone can contribute to. See [doc/dev.md](doc/dev.md) to help develop && maintain this tool.

<br>

## Library layout

A library is a folder which contain many dictionaries (which are just `git` repos). By default, dictionaries will be downloaded in `~/.cryptic-resolver` folder, this can't be configured. But, the user can specify an extra library using a config file.

```
Library
.
├── cryptic_common
├── cryptic_computer
├── cryptic_linux
├── cryptic_windows
├── ...
├── cryptic_economy
├── cryptic_x86
└── user_exam_dictionary
```

<br>

<a name="config-file"></a> 
## Config file

You can use a config file (in `TOML` format) which is specified by the environment variable `CRYPTIC_RESOLVER_CONFIG`. You can control two options in this config file:

1. Override the default dicts
2. Add an extra library for yourself, this way, you can manage multiple knowledge bases of your own, without the hassle of maintaining multiple git repos.

```toml
# cryptic-resolver.toml example

DEFAULT_DICTS = [
  "https://github.com/cryptic-resolver/cryptic_dos",
  "https://github.com/cryptic-resolver/cryptic_x86",
  "https://github.com/cryptic-resolver/cryptic_electronics"
]

EXTRA_LIBRARY = "C:\\MyData\\cr"
```

<br>

## Dictionary layout

`Dictionary` is a knowledge base. Every dictionary should be a `git` repository, and each consists of many files (we call these `sheets`):
```
Dictionary
.
├── 0-9.toml
├── a.toml
├── b.toml
├── c.toml
├── ...
├── y.toml
└── z.toml
```

## Sheet format (File format)

In every file(or sheet), your definition format looks like this in pure **toml**:
```toml
# A normal definition
#
# NOTICE: 
#   You MUST keep the key in lower case.
#   Use a key 'name' to display its original form 
#   Because the case sometimes contains details to help we understand
#
#   And 'name' && 'desc' is both MUST-HAVE. 
#   But if you use 'same', all other infos are not needed.   
#
[xdg]
name = "XDG"
desc = "Cross Desktop Group"

# If you want to explain more, use 'more'
[xxd]
name = "xxd"
desc = "hex file dump"
more = "Why call this 'xxd' rather than 'xd'?? Maybe a historical reason"

[xdm]
name = "XDM"
desc = "xdm without specifier"

# You can add a subkey as a category specifier to differ
# While the main word must be lower case, the category name can be any case!
[xdm.Download]
name = "XDM"
desc = "eXtreme Download Manager"

[xdm.Display]
name = "XDM"
desc = "X Display Manager"
```

**The search strategy is to treat words with or without a category specifier in the same way.**


More features:
```toml
[jpeg]
name = "JPEG"
desc = "Joint Photographic Experts Group"
more = "Introduced in 1992. A commonly used method of lossy compression for digital images"
see = 'MPG' # This is a `see also`
# see = ['MPG', 'PNG']  # when multiple see also, use array

[jpg]
name = "JPG"  # Show a good name
same = "jpeg" # We just need to redirect this. No duplicate!

[sth]
# You must point to a exact position, not just xdm
# And we use '=>' symbol to split it into two parts
#   the first will output to user
#   the second is for internal jump
same = "Extreme Downloader =>xdm.Download" 


# The 'dot' keyword supported using quoted strings
["h.265"]
name = "H.265"
desc = "A video compression standard" 

```

## Name collision

In one sheet, you should consider adding a category specifier to differ each other like the example above.

*But what if a dictionary has 'gdm' while another also has a 'GDM'?*

> cr can handle this.

*But what if a sheet has two 'gdm'?* 

> This will lead to toml's parser library fail. You have these solutions
> 1. Use a better lint for example: [VSCode's Even Better TOML](https://github.com/tamasfe/taplo)
> 2. Watch the fail message, you may notice 'override path xxx', the xxx is the collision, you may correct it back manually.

<br>

## LICENSE

`cr.rb` itself is under MIT

[Official dictionaries](#official-dictionaries) are all under CC-BY-4.0

[cryptic_common]: https://github.com/cryptic-resolver/cryptic_common
[cryptic_computer]: https://github.com/cryptic-resolver/cryptic_computer
[cryptic_windows]: https://github.com/cryptic-resolver/cryptic_windows
[cryptic_linux]: https://github.com/cryptic-resolver/cryptic_linux
[cryptic_electronics]: https://github.com/cryptic-resolver/cryptic_electronics

[tldr]: https://github.com/tldr-pages/tldr
[cheat]: https://github.com/cheat/cheat

[cryptic_economy]: https://github.com/cryptic-resolver/cryptic_economy
[cryptic_medicine]: https://github.com/cryptic-resolver/cryptic_medicine
[cryptic_science]: https://github.com/cryptic-resolver/cryptic_science
[cryptic_mechanical]: https://github.com/cryptic-resolver/cryptic_mechanical
[cryptic_math]: https://github.com/cryptic-resolver/cryptic_math

[cryptic_dos]: https://github.com/cryptic-resolver/cryptic_dos
[cryptic_x86]: https://github.com/cryptic-resolver/cryptic_x86
[cryptic_signal]: https://github.com/cryptic-resolver/cryptic_signal