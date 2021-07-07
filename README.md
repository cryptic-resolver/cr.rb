# cr: Cryptic Resolver

> cr: a general Cryptic Resolver. cr isn't Cryptic Really. 

This general command line tool is used to **record and explain the cryptic commands, acronyms** in daily life.
Not only can it be used in computer filed, but also you can use this to manager your own knowledge base easily.

The aim of this projects is to:

1. make cryptic things clear
2. help maintain your own personal knwoledge base

rather than

1. record the use of a command, for this you can refer to tldr, cheat and so on. 


<br>


# Implementation

cr is Written in pure Ruby. You can implement this tools in any other langauge you like(name your projects as cr_python for example), just remember to reuse our [cryptic_computer] or other sheets which is the core part anyone can contribute to.

## Sheet layout

Every sheet should be a git repository. And every sheet should contain these files(we call these dictionarys):

1. 0123456789.toml
2. a.toml
3. b.toml
3. ...
4. z.toml

and in every file, your definition format looks like this in pure toml:
```toml
# a normal definition
# notice that we want to keep the key case unsenstive
# because the case sometimes contains  details to help we understand
[XDG]
desc = "Cross Desktop Group"

# If you want to explain more, use 'full'
[xxd]
desc = "hex file dump"
full = "Why call this 'xxd' rather than 'xd'?? Maybe a historical reason"

# if there are multiple meanings, you should add a subkey to differ
[XDM.Download]
desc = "eXtreme Download Manager"

[XDM.Display]
desc = "X Display Manager"
```

<br>

# LICENSE
cr is under GPL

[cryptic_computer] is under CC-BY


[cryptic_computer]: https://github.com/cryptic-less/cryptic_computer
