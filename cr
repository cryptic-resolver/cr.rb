#!/usr/bin/env ruby
# coding: utf-8
#  ---------------------------------------------------
#  File          : cr.rb
#  Authors       : ccmywish <leslieranaa@qq.com>
#  Created on    : <2021-6-8>
#  Last modified : <2021-6-8>
#
#  This file is used to explain a CRyptic command
#  or an acronym's real meaning in computer world or 
#  orther fileds.  
#
#  Usage:
#
#    $ cr a_com_d
#    -> It means A COMmanD 
#
#    $ cr -u 
#    -> update cryptic computer sheets from the 
#    -> central repo by default
#
#    $ cr -u github.com/ccmywish/ruby_things.git
#    -> Add your own knowledge base! 
#
#    $ cr -h
#    -> show help
#  ---------------------------------------------------

require 'toml'

CRYPTIC_LESS_HOME = File.expand_path("~/.cryptic-less")
CRYPTIC_DEFAULT_SHEETS = {
  computer: "github.com/cryptic-less/cryptic_computer.git"
}

def is_there_any_sheet?
  unless Dir.exist? CRYPTIC_LESS_HOME
    Dir.mkdir CRYPTIC_LESS_HOME
  end

  Dir.empty? CRYPTIC_LESS_HOME 
end


def update_sheets(sheet_repo)

  unless is_there_any_sheet?
    CRYPTIC_DEFAULT_SHEETS.each_key do |sheet|
      `git -C #{CRYPTIC_LESS_HOME} clone #{sheet}`
    end
    return
  end

  if sheet_repo.nil?
    Dir.chdir CRYPTIC_LESS_HOME do 
      Dir.children CRYPTIC_LESS_HOME do |sheet|
        `git -C ./#{sheet} pull`
      end
    end
  end

end


def load_dictionary(path,file)
  file = CRYPTIC_LESS_HOME + "/#{path}/#{file}.toml" 
  
  if File.exist? file
    return TOML.load_file file
  else
    nil
  end
end


# pretty print the info of the word
def pp_info(info)
  puts ""
  puts " - #{info['desc']}"
  puts 
  if msg = info['full']
    puts msg 
  end
end


# lookup into a dictionary
def lookup(path, file, word)
  # only one meaning
  dicts = load_dictionary(path,file) 
  return false if dicts.nil?
  
  # We want keys in toml be case-insenstive. 
  # So we only can use array to find them, but this may leave performance problem when data grows.
  # If we use hash, the toml keys must be downcase, the situation where we really avoid. 
  word = dicts.keys.select {|k| k.downcase == word} .first

  info = dicts[word]
  return false if info.nil?

  if info['desc']
    pp_info(info)
    return true
  end

  # multi meanings
  info = info.keys

  unless info.empty?
    info.each do |meaning|
      pp_info dicts[word][meaning]
      puts "==========" unless info.last == meaning # last meaning doesn't show this separate line
    end
    return true
  else
    return false
  end
end


def solve_word(word)
  word = word.downcase # downcase! would lead to frozen error in Ruby 2.7.2
  index = word.chr
  case index 
  when '0'..'9' 
    index = '0123456789'
  end
  
  # Default's first should be 1st to consider
  first_sheet = "cryptic_" + CRYPTIC_DEFAULT_SHEETS.keys[0].to_s # When Ruby3, We can use SHEETS.key(0)
  result = lookup(first_sheet,index,word)
  return if result == true

  # Then else
  rest = Dir.children(CRYPTIC_LESS_HOME)
  rest.delete first_sheet do |sheet|
    result = lookup(sheet,index,word)
    continue if result == false
  end

  if result == false
    puts "cr: Not found anything."
    puts
    puts "Could you please figure it out and help others learn?"
    puts "Welcome to contribute to our sheets: "
    puts
    puts "  computer: https://github.com/cryptic-less/cryptic_computer"
    puts 
    puts "Thanks!"
  else
    return
  end
  
end


def help
  puts "cr: a general Cryptic Resolver. cr isn't Cryptic Really. "
  puts
  puts "usage:"
  puts "  cr -h                         => print this help"
  puts "  cr -u (xx.com/user/repo.git)  => update 'computer' sheets by default or sheets from a git repo"
  puts "  cr emacs                      => Edit macros: a feature-riched editor"
end



####################
# main: CLI Handling
####################
arg = ARGV.shift

case arg
when nil            then help
when '-h'           then help
when '-u'           then update_sheets   ARGV.shift
else
  solve_word arg
end
 