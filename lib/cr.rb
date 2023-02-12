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

  GEM_VERSION = "4.0.4"

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


  def initialize
    # if user doesn't specify, we use the hard-coded defaults
    DEFAULT_DICTS = ORIGINAL_DEFAULT_DICTS

    # The config file will override the default dicts, but not default library!
    if file = ENV['CRYPTIC_RESOLVER_CONFIG']

      if !test('f', file)
        abort "FATAL: Your CRYPTIC_RESOLVER_CONFIG is NOT a file!"
      end

      config = Tomlrb.load_file file

      DEFAULT_DICTS = ret if ret = config['DEFAULT_DICTS']

      EXTRA_LIB_PATH ||= config['EXTRA_LIBRARY']
      # Prevent runtime error
      if ! test('d', EXTRA_LIB_PATH)
        abort "FATAL: Your CRYPTIC_RESOLVER_CONFIG's option 'EXTRA_LIBRARY' is NOT a legal directory!"
      end

    else
      EXTRA_LIB_PATH = nil
    end


    # This is used to display what you are pulling when adding dicts
    DEFAULT_DICTS_USER_AND_NAMES = DEFAULT_DICTS.map do |e|
      user, repo = e.split('/').last(2)
      repo = repo.split('.').first
      user + '/' + repo
    end

    # Same with the pulled repo dirs' names in DEFAULT_LIB_PATH
    DEFAULT_DICTS_NAMES = DEFAULT_DICTS.map do |e|
      e.split('/').last.split('.').first
    end



  end

end

