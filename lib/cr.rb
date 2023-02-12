# ------------------------------------------------------
# File          : cr.rb
# Authors       : ccmywish <ccmywish@qq.com>
# Created on    : <2022-04-15>
# Last modified : <2023-02-12>
#
# cr:
#
#   This file is the lib of `cr.rb``
# ------------------------------------------------------

module CrypticResolver

  GEM_VERSION = "4.1.0"

end


class CrypticResolver::Resolver

  def bold(str)       "\e[1m#{str}\e[0m" end
  def underline(str)  "\e[4m#{str}\e[0m" end
  def red(str)        "\e[31m#{str}\e[0m" end
  def green(str)      "\e[32m#{str}\e[0m" end
  def yellow(str)     "\e[33m#{str}\e[0m" end
  def blue(str)       "\e[34m#{str}\e[0m" end
  def purple(str)     "\e[35m#{str}\e[0m" end
  def cyan(str)       "\e[36m#{str}\e[0m" end

end



class CrypticResolver::Resolver

  require 'tomlrb'

  # attr_accessor   :default_dicts  # Default dictionaries lists

  DEFAULT_LIB_PATH = File.expand_path("~/.cryptic-resolver")

  ORIGINAL_DEFAULT_DICTS = [
    "https://github.com/cryptic-resolver/cryptic_common.git",
    "https://github.com/cryptic-resolver/cryptic_computer.git",
    "https://github.com/cryptic-resolver/cryptic_windows.git",
    "https://github.com/cryptic-resolver/cryptic_linux.git",
    "https://github.com/cryptic-resolver/cryptic_technology"
  ]

  RECOMMENDED_DICTS = <<~EOF
  Default:
    common       computer    windows
    linux       technology

  Field:
    electronics   economy     medicine
    mechanical   science       math

  Specific:
    dos         x86        signal

  Feature:
    ccmywish/CRuby-Source-Code-Dictionary

  EOF



  attr_accessor :def_dicts,        # default dictionaries lists
                :extra_lib_path,   # Extra library path
                :counter           # word counter

  def initialize
    @counter =  Counter.new

    # if user doesn't specify, we use the hard-coded defaults
    @def_dicts = ORIGINAL_DEFAULT_DICTS

    # The config file will override the default dicts, but not default library!
    if file = ENV['CRYPTIC_RESOLVER_CONFIG']

      if !test('f', file)
        abort "FATAL: Your CRYPTIC_RESOLVER_CONFIG is NOT a file!"
      end

      config = Tomlrb.load_file file

      if ret = config['DEFAULT_DICTS']
        @def_dicts = ret
      end

      @extra_lib_path ||= config['EXTRA_LIBRARY']
      # Prevent runtime error
      if ! test('d', @extra_lib_path)
        abort "FATAL: Your CRYPTIC_RESOLVER_CONFIG's option 'EXTRA_LIBRARY' is NOT a legal directory!"
      end
    else
      @extra_lib_path = nil
    end

    # Same with the pulled repo dirs' names in DEFAULT_LIB_PATH
    # @def_dicts_names = @def_dicts.map do |e|
    #  e.split('/').last.split('.').first
    # end


  end


  def is_there_any_dict?
    unless Dir.exist? DEFAULT_LIB_PATH
      Dir.mkdir DEFAULT_LIB_PATH
    end
    !Dir.empty? DEFAULT_LIB_PATH
  end


  def add_default_dicts_if_none_exists
    unless is_there_any_dict?
      puts "cr: Adding default dicts..."

      # This is used to display what you are pulling when adding dicts
      dicts_user_and_names = @def_dicts.map do |e|
        user, repo = e.split('/').last(2)
        repo = repo.split('.').first
        user + '/' + repo
      end

      begin
      if Gem.win_platform?
        # Windows doesn't have fork
        dicts_user_and_names.each_with_index do |name, i|
          puts "cr: Pulling #{name}..."
          `git -C #{DEFAULT_LIB_PATH} clone #{CR_DEFAULT_DICTS[i]} -q`
        end
      else
        # *nix-like
        dicts_user_and_names.each_with_index do |name, i|
          fork do
            puts "cr: Pulling #{name}..."
            `git -C #{DEFAULT_LIB_PATH} clone #{CR_DEFAULT_DICTS[i]} -q`
          end
        end
        Process.waitall
      end

      rescue Interrupt
      abort "cr: Cancel add default dicts"
      end

      puts "cr: Add done" ; word_count(p: false)
      puts ; puts "#{$DefaultLibWordCount} words added"

      # Really added
      return true
    end
    # Not added
    return false
  end


end


class CrypticResolver::Resolver::Counter

  attr_accessor :word_count_of_two_libs,  # def_lib + extra_lib
                :word_count_of_def_lib,
                :word_count_of_extra_lib


  def initialize
    @word_count_of_two_libs = 0
    @word_count_of_def_lib = 0
    @word_count_of_extra_lib = 0
  end


  def count_dict_words(library, dict)
    dict_dir = library + "/#{dict}"
    wc = 0
    Dir.children(dict_dir).each do |entry|
      next unless entry.end_with?('.toml')
      sheet_content = load_sheet(library, dict, entry.delete_suffix('.toml'))
      count = sheet_content.keys.count

      wc = wc + count
    end
    return wc
  end

end
