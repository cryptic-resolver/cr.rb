<div align="center">

**Cryptic Resolver**

[English](README.md)

[![word-count](https://img.shields.io/badge/Keywords%20Inlcuded-232-brightgreen)](#default-sheets)
[![Gem Version](https://badge.fury.io/rb/cryptic-resolver.svg)](https://rubygems.org/gems/cryptic-resolver) 
 
![screenshot](./images/screenshot.png)

</div>

这个命令行工具 `cr` 用于**记录和解释计算机领域的命令以及日常生活中的缩略词等**。
这项工作是为了研究词源，了解命名惯例。

它不仅可以用于计算机领域，而且您还可以使用它轻松管理自己的知识库。

- 目前，我们在默认工作表中已解释了 **232** 个关键词。

<br>

<a name="default-sheets"></a> 
## 默认工作表(Sheet)

- [cryptic_computer]
- [cryptic_common]

<br>

## 安装

```bash
gem install cryptic-resolver
```

在 `Ubuntu` 和 `Winodws 11` 上测试良好

<br>

## 为什么要开发/使用 cr

本项目的目标是：

1. 把隐秘的事情弄清楚
2. 帮助维护您自己的知识库

而不是

1. 记录命令的使用情况，为此您可以参考 [tldr]、[cheat]

<br>

# 使用方法

```bash
$ cr emacs
# -> Emacs: Edit macros
# ->
# ->   a feature-rich editor
# ->
# -> SEE ALSO Vim 

$ cr -u 
# -> 更新所有sheets

$ cr -u https://github.com/ccmywish/ruby_things.git
# -> 增加您自己的知识库! 

$ cr -h
# -> 显示帮助
```


<br>

# 多种实现

`cr` 是用 **Ruby** 编写的。你可以用你喜欢的任何其他语言来实现这个工具（例如，把你的项目命名为 `cr_python`，只要记住重用我们的[cryptic_computer] 或其他表单（Sheet，知识库），它们是任何人都可以贡献的核心部分。


## Sheet格式

Sheet就是知识库。每一个Sheet都应当是一个Git仓库，且需要包含这些文件（我们称之为dictionaries(字典)）

1. 0123456789.toml
2. a.toml
3. b.toml
3. ...
4. z.toml

## 字典格式（文件格式）

在每个字典（文件）中，您的格式需要像下面这样使用纯**toml**
```toml
# 一个普通的定义
#
# 注意: 
#   我们必须让单词小写
#   我们使用键 'disp' 来显示其原始形式
#   因为大小写有时包含一些细节来帮助我们理解
#
#   'disp' 和 'desc' 是必须的
#   但是如果你使用了'same', 其他都是不必要的
#
[xdg]
disp = "XDG"
desc = "Cross Desktop Group"

# 如果你想记录更多，使用 'full' 
[xxd]
disp = "xxd"
desc = "hex file dump"
full = "Why call this 'xxd' rather than 'xd'?? Maybe a historical reason"

# 如果有多重含义，你应当添加一个子键来区分，该子键通常表示分类
[xdm.Download]
disp = "XDM"
desc = "eXtreme Download Manager"

[xdm.Display]
disp = "XDM"
desc = "X Display Manager"
```

`cr` 还有更多的功能
```toml
[jpeg]
disp = "JPEG"
desc = "Joint Photographic Experts Group"
full = "Introduced in 1992. A commonly used method of lossy compression for digital images"
see = ['MPG','PNG'] # 这是一个 `see also`

[jpg]
same = "JPEG" # 我们仅需要跳转到另一个单词，没有重复!

[sth]
same = "xdm" # 如果我们要跳转到一个多含义的词，我们不需要指明它的子键（分类）

["h.265"]
disp = "H.265"
desc = "A video compression standard" # 通过使用双引号来支持 '.'(点号)

```

## 命名冲突

在一个表中，您应该考虑添加子键来区别彼此，如上面的示例。

*但是，如果一个工作表有"gdm"，而另一个工作表也有"gdm"，该怎么办?*

> 这没什么，因为 cr 知道这一点。

*但如果一张工作表有两个"gdm"怎么办？*

> 这将导致toml的解析器库失败。你有这些解决方案

> 1. 使用更好的lint，例如：[VSCode's Even Better TOML](https://github.com/tamasfe/taplo)
> 2. 观察失败消息，您可能会注意到 'override path xxx'，这个 xxx 就是冲突，您可以手动更正它。

<br>

## cr 在Ruby中的开发

也许您需要 `sudo` 权限

- `gem build cryptic-resolver`
- `gem install cryptic-resolver -l`
- `gem uninstall cryptic-resolver`
- `gem update cryptic-resolver (--pre)`
- `gem push cryptic-resolver-x.x.gem`

<br>

# LICENSE
cr 使用MIT协议

[cryptic_computer] 使用CC-BY-4.0协议


[cryptic_computer]: https://github.com/cryptic-resolver/cryptic_computer
[cryptic_common]: https://github.com/cryptic-resolver/cryptic_common
[tldr]: https://github.com/tldr-pages/tldr
[cheat]: https://github.com/cheat/cheat
