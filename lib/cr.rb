# ------------------------------------------------------
# File          : cr.rb
# Authors       : Aoran Zeng <ccmywish@qq.com>
# Created on    : <2022-04-15>
# Last modified : <2023-08-15>
#
# cr:
#
#   This file is the lib of `cr.rb``
# ------------------------------------------------------

require 'rainbow/refinement'
require_relative 'cr/version'

class CrypticResolver::Resolver

  using Rainbow

  require_relative 'cr/counter'

  # Notice that we only update the Default library, not Extra library
  def update_dicts

    @counter.count_def_lib(display: false)
    old_wc = @counter.word_count_of_def_lib

    puts "cr: Updating all dicts in Default library..."

    begin
    Dir.chdir DEFAULT_LIB_PATH do
      if Gem.win_platform?
        # Windows doesn't have fork
        Dir.children(DEFAULT_LIB_PATH).each do |dict|
          next if File.file? dict
          puts "cr: Wait to update #{dict}..."
          `git -C ./#{dict} pull -q`
        end
      else
        # *nix
        Dir.children(DEFAULT_LIB_PATH).each do |dict|
          next if File.file? dict
          fork do
            puts "cr: Wait to update #{dict}..."
          `git -C ./#{dict} pull -q`
          end
        end
        Process.waitall
      end # end if/else
    end

    rescue Interrupt
    abort "cr: Cancel update"
    end

    puts "cr: Update done"

    # clear
    @counter.word_count_of_def_lib = 0
    # recount
    @counter.count_def_lib(display: false)

    new_wc = @counter.word_count_of_def_lib
    puts ; puts "#{new_wc - old_wc} words added in Default library"
  end


  def add_dict(repo)
    if repo.nil?
      abort "cr: Need an argument!".bold.red
    end

    # Simplify adding dictionary
    if !repo.start_with?("https://") and !repo.start_with?("git@")
      if repo.include?('/')
        repo = "https://github.com/#{repo}.git"
      else
        repo = "https://github.com/cryptic-resolver/cryptic_#{repo}.git"
      end
    end

    begin
    puts "cr: Adding new dictionary..."
    # Note that, we must add "" to surround the dir
    # Because some path (e.g. macOS) will have spaces
    `git -C "#{DEFAULT_LIB_PATH}" clone #{repo} -q`
    rescue Interrupt
    abort "cr: Cancel add dict"
    end

    puts "cr: Add new dictionary done"

    # github/com/ccmywish/ruby_knowledge(.git)
    dict = repo.split('/')[-1].delete_suffix('.git')
    wc = @counter.count_dict_words(DEFAULT_LIB_PATH ,dict)
    puts ; puts "#{wc} words added"
  end


  def del_dict(repo)
    if repo.nil?
      abort "cr: Need an argument!".bold.red
    end
    Dir.chdir DEFAULT_LIB_PATH do
      begin
      # Dir.rmdir repo        # Can't rm a filled dir
      # FileUtils.rmdir repo  # Can't rm a filled dir
      FileUtils.rm_rf repo
      puts "cr: Delete dictionary #{repo.bold.green} done"
      rescue Exception => e
      puts "cr: #{e}".bold.red
      list_dicts
      end
    end
  end


  def load_sheet(library, dict, sheet_name)
    file = library + "/#{dict}/#{sheet_name}.toml"
    if File.exist? file
      return Tomlrb.load_file file # gem 'tomlrb'
      # return TOML.load_file file # gem 'toml'
    else nil end
  end


=begin
Pretty print the info of the given word

A info looks like this
  emacs = {
    name = "Emacs"
    desc = "edit macros"
    more = "a feature-rich editor"
    see  = ["Vim"]
  }

@param info [Hash] the information of the given word (mapped to a keyword in TOML)
=end
  def pp_info(info)
    name = info['name'] || "No name!".red  # keyword `or` is invalid here in Ruby

    desc = info['desc']
    more = info['more']

    if desc
      puts "\n  #{name}: #{desc}"
      print "\n  ",more,"\n" if more
    else
      puts "\n  #{name}"
      print "\n  ",more,"\n" if more
    end

    if see_also = info['see']
      print "\n", "SEE ALSO ".magenta
      if see_also.is_a?(Array)
        last_ndx = see_also.size - 1
        see_also.each_with_index do |x,i|
          if last_ndx == i
            print x.underline  # Last word doesn't show space
          else
            print x.underline, ' '
          end
        end
      else
        print see_also.underline
      end
      puts
    end
    puts
  end


  # Print default cryptic_ dicts
  def pp_dict(dict)
    puts "From: #{dict}".green
  end


=begin
  Used for synonym jump
  Because we absolutely jump to a must-have word
  So we can directly lookup to it

  Notice that, we must jump to a specific word definition
  So in the toml file, you must specify the precise word.
  If it has multiple meanings, for example

  [blah]
  same = "xdg"  # this is wrong, because xdg has multiple
                # definitions, and all of them specify a
                # category

  [blah]
  same = "XDG downloader =>xdg.Download" # this is correct

  [blah]
  name = "BlaH" # You may want to display a better name first
  same = "XDG downloader =>xdg.Download" # this is correct
=end
  def pp_same_info(library, dict, word, cache_content, same_key, own_name)

    # If it's a synonym for anther word,
    # we should lookup into this dict again, but maybe with a different file

    # file name
    x = word.chr.downcase

=begin
    dictionary maintainer must obey the rule for xxx.yyy word:
    xxx should be lower case
    yyy can be any case

    Because yyy should clearly explain the category info, IBM is better than ibm
    Implementation should not be too simple if we want to stress the function we
    expect.

    'jump to' will output to user, so this is important not only inside our sheet.

      same = "XDM downloader=>xdm.Download"

    We split 'same' key into two parts via spaceship symbol `=>`, first part will
    output to user, the second part is for internal jump.
=end
    jump_to, same = same_key.split("=>")
    same =  jump_to if same.nil?

    unless own_name
      own_name = word
    end
    puts own_name.bold.blue + ' redirects to ' + jump_to.bold.blue

=begin
    As '.' is used to delimit a word and a category, what if
    we jump to a dotted word?

      [eg]
      same = "e.g." # this must lead to a wrong resolution to
                    # word 'e', category 'g'

      All you need is to be like this:

      [eg]
      same = "'e.g.'" # cr will notice the single quote
=end
    if same =~ /^'(.*)'$/
      same, category = $1, nil
    else
      same, category = same.split('.')
    end

    if same.chr == x
      # No need to load another dictionary if match
      sheet_content = cache_content
    else
      sheet_content = load_sheet(library, dict, same.chr.downcase)
    end

    if category.nil?
      info = sheet_content[same]
    else
      info = sheet_content[same][category]
    end

    if info.nil?
      puts "WARN: Synonym jumps to the wrong place `#{same}`,
      Please consider fixing this in `#{x}.toml` of the dictionary `#{dict}`".red
      # exit
      return false
    # double or more jumps
    elsif same_key = info['same']
      own_name = info['name']
      return pp_same_info(library, dict, same, cache_content, same_key, own_name)
    else
      pp_info(info)
      return true
    end
  end


  # Lookup the given word in a sheet (a toml file) and also print.
  # The core idea is that:
  #
  # 1. if the word is `same` with another synonym, it will directly jump to
  #   a word in this dictionary, but maybe a different sheet.
  #
  # 2. load the toml file and check the given word
  #   2.1 with no category specifier
  #       [abcd]
  #   2.2 with category specifier
  #       [abcd.tYPe]
  #
  def lookup(library, dict, file, word)
    sheet_content = load_sheet(library, dict, file)
    return false if sheet_content.nil?

    info = sheet_content[word]
    return false if info.nil?

    # Warn if the info is empty. For example:
    #   emacs = { }
    if info.size == 0
      abort "WARN: Lack of everything of the given word
      Please consider fixing this in the dict `#{dict}`".red
    end

    # Word with no category specifier
    # We call this meaning as type 1
    type_1_exist_flag = false

    # if already jump, don't check the word itself
    is_jump = false

    # synonym info print
    if same_key = info['same']
      own_name = info['name']
      pp_dict(dict)
      pp_same_info(library, dict, word, sheet_content, same_key, own_name)
      # It's also a type 1
      type_1_exist_flag = true
      is_jump = true
    end

    # normal info print
    # To developer:
    #   The word should at least has one of `desc` and `more`
    #   But when none exists, this may not be considered wrong,
    #   Because the type2 make the case too.
    #
    #   So, just ignore it, even if it's really a mistake(insignificant)
    #   by dictionary maintainers.
    #
    if !is_jump && (info.has_key?('desc') || info.has_key?('more'))
      pp_dict(dict)
      pp_info(info)
      type_1_exist_flag = true
    end

    # Meanings with category specifier
    # We call this meaning as type 2
    categories = info.keys - ["name", "desc", "more", "same", "see"]

    if !categories.empty?

      if type_1_exist_flag
        print "OR".bold.blue, "\n"
      else
        pp_dict(dict)
      end

      categories.each do |meaning|
        info0 = sheet_content[word][meaning]
        if same_key = info0['same']
          own_name = info0['name']
          pp_same_info(library, dict, word, sheet_content, same_key, own_name)
        else
          pp_info(info0)
        end

        # last meaning doesn't show this separate line
        print "OR".bold.blue, "\n" unless categories.last == meaning
      end
      return true
    elsif type_1_exist_flag then return true
    else return false end
  end


  # The main procedure of `cr`
  #
  #   1. Search the default library first
  #   2. Search the extra library if it does exist
  #
  # The `search` is done via the `lookup` function. It will print
  # the info while finding. If `lookup` always return false then
  # means lacking of this word in our dicts. So a welcomed
  # contribution is printed on the screen.
  #
  def resolve_word(word)

    word = word.downcase # downcase! would lead to frozen error in Ruby 2.7.2
    # The index is the toml file we'll look into
    index = word.chr
    case index
    when '0'..'9'
      index = '0-9'
    end

    # cache lookup's results
    results = []

    # First consider the default library
    default = Dir.children(DEFAULT_LIB_PATH)
    default.each do |dict|
      results << lookup(DEFAULT_LIB_PATH,dict,index,word)
    end

    # Then is the extra library
    if @extra_lib_path
      extra = Dir.children(@extra_lib_path)
      extra.each do |dict|
        results << lookup(@extra_lib_path,dict,index,word)
      end
    end

    unless results.include? true
      puts <<~NotFound
      cr: Not found anything about '#{word}'. You could try

      #{"case 1: Update all dictionaries".blue}
       #{"$ cr -u".yellow}
      #{"case 2: List available official and feature dictionaries".blue}
       #{"$ cr -l".yellow}
       #{"$ cr -a repo".yellow} (Add a specific dict to default lib)
      #{"case 3: Contribute to theses dictionaries".blue}
       Visit: https://github.com/cryptic-resolver

      NotFound
    else return end
  end


  # Delegate to `search_word_internal`
  #
  def search_related_words(pattern)
    found_or_not1 = false
    found_or_not2 = false

    found_or_not1 = search_related_words_internal(pattern, DEFAULT_LIB_PATH)
    if @extra_lib_path
      found_or_not2 = search_related_words_internal(pattern, @extra_lib_path)
    end

    if (found_or_not1 == false) && (found_or_not2 == false)
      puts "cr: No words match with #{pattern.inspect}".red ; puts
    end
  end


  # This routine is quite like `resolve_word`
  #
  # Notice:
  #   We handle two cases
  #
  #   1. the 'pattern' is the regexp itself
  #   2. the 'pattern' is like '/blah/'
  #
  #  The second is what Ruby and Perl users like to do, handle it!
  #
  def search_related_words_internal(pattern, library)

    if pattern.nil?
      abort "cr: Need an argument!".bold.red
    end

    if pattern =~ /^\/(.*)\/$/
      regexp = %r[#$1]
    else
      regexp = %r[#{pattern}]
    end

    found_or_not = false

    # Try to match every word in all dicts
    Dir.children(library).each do |dict|

      path = File.join(library, dict)
      next if File.file? path
      sheets = Dir.children(path).select do
        _1.end_with?('.toml')
      end

      similar_words_in_a_dict = []

      sheets.each do |sheet|
        sheet_content = load_sheet(library, dict, File.basename(sheet,'.toml'))

        sheet_content.keys.each do
          if _1 =~ regexp
            found_or_not = true
            similar_words_in_a_dict << _1
          end
        end
      # end of each sheet in a dict
      end

      unless similar_words_in_a_dict.empty?
        pp_dict(dict)
        require 'ls_table'
        LsTable.ls(similar_words_in_a_dict) do |e|
          puts e.blue
        end
        puts
      end
    end
    return found_or_not
  end


  # 1. List Default library's dicts
  # 2. List Extra   library's dicts
  # 3. List official dicts
  def list_dicts

    def _do_the_same_thing
      count = 0
      Dir.children(".").each do |dict|
        next if File.file? dict
        count += 1
        prefix = (count.to_s + '.').ljust 4
        puts "  #{prefix}#{dict}"
      end
    end

    Dir.chdir DEFAULT_LIB_PATH do
      puts "Default library: #{DEFAULT_LIB_PATH}".bold.green
      _do_the_same_thing
    end

    if @extra_lib_path
      puts
      Dir.chdir @extra_lib_path do
        puts "Extra library: #{@extra_lib_path}".bold.green
        _do_the_same_thing
      end
    end

    puts ; puts "Official dictionaries: (Add it by 'cr -a xxx')".bold.green
    puts RECOMMENDED_DICTS
  end


  def count_words
    @counter.count!(display: true)
  end

end



class CrypticResolver::Resolver

  using Rainbow

  require 'tomlrb'
  require 'fileutils'
  require 'standard_path'

  # attr_accessor   :default_dicts  # Default dictionaries lists

  DEFAULT_LIB_PATH = StandardPath.app_data 'Cryptic-Resolver'

  ORIGINAL_DEFAULT_DICTS = [
    "https://github.com/cryptic-resolver/cryptic_common.git",
    "https://github.com/cryptic-resolver/cryptic_computer.git",
    "https://github.com/cryptic-resolver/cryptic_windows.git",
    "https://github.com/cryptic-resolver/cryptic_linux.git",
    "https://github.com/cryptic-resolver/cryptic_technology"
  ]

  RECOMMENDED_DICTS = <<~EOF
  #{"Default:".yellow}
    common       computer    windows
    linux       technology

  #{"Field:".yellow}
    economy     medicine   electronics
    science       math

  #{"Specific:".yellow}
      x86        signal

  #{"Feature:".yellow}
    ccmywish/CRuby-Source-Code-Dictionary

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
          `git -C "#{DEFAULT_LIB_PATH}" clone #{@def_dicts[i]} -q`
        end
      else
        # *nix-like
        dicts_user_and_names.each_with_index do |name, i|
          fork do
            puts "cr: Pulling #{name}..."
            `git -C "#{DEFAULT_LIB_PATH}" clone #{@def_dicts[i]} -q`
          end
        end
        Process.waitall
      end

      rescue Interrupt
      abort "cr: Cancel add default dicts"
      end

      puts "cr: Add done" ;
      @counter.count_def_lib(display: false)
      puts ; puts "#{@counter.word_count_of_def_lib} words added"
      @counter.reset!

      # Really added
      return true
    end
    # Not added
    return false
  end

end
