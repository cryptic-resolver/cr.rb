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

require 'cr/version'

module CrypticResolver

  module Color
    def bold(str)       "\e[1m#{str}\e[0m" end
    def underline(str)  "\e[4m#{str}\e[0m" end
    def red(str)        "\e[31m#{str}\e[0m" end
    def green(str)      "\e[32m#{str}\e[0m" end
    def yellow(str)     "\e[33m#{str}\e[0m" end
    def blue(str)       "\e[34m#{str}\e[0m" end
    def purple(str)     "\e[35m#{str}\e[0m" end
    def cyan(str)       "\e[36m#{str}\e[0m" end
  end

end


class CrypticResolver::Resolver

  include CrypticResolver::Color

  require 'tomlrb'
  require 'fileutils'

  # attr_accessor   :default_dicts  # Default dictionaries lists

  DEFAULT_LIB_PATH = File.expand_path("~/.cryptic-resolver")

  ORIGINAL_DEFAULT_DICTS = [
    "https://github.com/cryptic-resolver/cryptic_common.git",
    "https://github.com/cryptic-resolver/cryptic_computer.git",
    "https://github.com/cryptic-resolver/cryptic_windows.git",
    "https://github.com/cryptic-resolver/cryptic_linux.git",
    "https://github.com/cryptic-resolver/cryptic_technology"
  ]

  extend CrypticResolver::Color

  RECOMMENDED_DICTS = <<~EOF
  #{yellow("Default:")}
    common       computer    windows
    linux       technology

  #{yellow("Field:")}
    electronics   economy     medicine
    mechanical   science       math

  #{yellow("Specific:")}
    dos         x86        signal

  #{yellow("Feature:")}
    ccmywish/CRuby-Source-Code-Dictionary
    ccmywish/mruby-Source-Code-Dictionary

  EOF



  attr_accessor :def_dicts,        # default dictionaries lists
                :extra_lib_path,   # Extra library path
                :counter           # word counter

  def initialize
    @counter =  Counter.new(self)

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
    # Ensure the cr home dir exists
    FileUtils.mkdir_p(DEFAULT_LIB_PATH)
    #unless Dir.exist? DEFAULT_LIB_PATH
    # Dir.mkdir DEFAULT_LIB_PATH
    #end
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

  include CrypticResolver::Color

  attr_accessor :word_count_of_two_libs,  # def_lib + extra_lib
                :word_count_of_def_lib,
                :word_count_of_extra_lib,

                :resolver

  def initialize(resolver)
    @word_count_of_two_libs = 0
    @word_count_of_def_lib = 0
    @word_count_of_extra_lib = 0
    @resolver = resolver
  end


  def count_dict_words(library, dict)
    dict_dir = library + "/#{dict}"
    wc = 0
    Dir.children(dict_dir).each do |entry|
      next if File.file? entry
      next unless entry.end_with?('.toml')
      sheet_content = @resolver.load_sheet(library, dict, entry.delete_suffix('.toml'))
      count = sheet_content.keys.count

      wc = wc + count
    end
    return wc
  end


  # Count default library
  def count_def_lib(display: )
    default_lib = Dir.children(CrypticResolver::Resolver::DEFAULT_LIB_PATH)
    unless default_lib.empty?
      puts bold(green("Default library: "))  if display
      default_lib.each do |s|
        next if File.file? s
        wc = count_dict_words(CrypticResolver::Resolver::DEFAULT_LIB_PATH,s)
        @word_count_of_def_lib += wc
        # With color, ljust not works, so we disable color
        puts("#{wc.to_s.rjust(5)}  #{s}")   if display
      end
    end
    return @word_count_of_def_lib
  end


  # Count extra library
  def count_extra_lib(display: )
    if path = @resolver.extra_lib_path
      extra_lib = Dir.children(path)
      unless extra_lib.empty?
        wc = 0
        puts(bold(green("\nExtra library:")))  if display
        extra_lib.each do |s|
          next if File.file? s
          wc = count_dict_words(path,s)
          @word_count_of_extra_lib += wc
          puts("#{wc.to_s.rjust(5)}  #{s}")  if display
        end
      end
    end
    return @word_count_of_extra_lib
  end


  def count!(display: )
    count_def_lib(display: display)
    count_extra_lib(display: display)
    @word_count_of_two_libs = @word_count_of_def_lib + @word_count_of_extra_lib

    if display
    puts
    puts "#{@word_count_of_def_lib.to_s.rjust(4)} words in Default library"
    puts "#{@word_count_of_extra_lib.to_s.rjust(4)  } words in  Extra  library"
    puts "#{@word_count_of_two_libs.to_s.rjust(4)    } words altogether"
    end
  end

end
