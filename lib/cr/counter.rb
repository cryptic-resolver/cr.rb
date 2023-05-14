# ---------------------------------------------------------------
# File          : counter.rb
# Authors       : Aoran Zeng <ccmywish@qq.com>
# Created on    : <2022-03-06>
# Last modified : <2023-05-14>
#
# counter:
#
#   Count words in dictionaries.
# ---------------------------------------------------------------

class CrypticResolver::Resolver::Counter

  using Rainbow

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

  # a.toml
  # b.toml
  # ...
  def count_dict_words(library, dict)
    dict_dir = library + "/#{dict}"
    wc = 0
    Dir.children(dict_dir).each do |entry|
      next unless entry.end_with?('.toml')
      next if File.directory? dict_dir + "/#{entry}"
      sheet_content = @resolver.load_sheet(library, dict, entry.delete_suffix('.toml'))
      count = sheet_content.keys.count

      wc = wc + count
    end
    return wc
  end


  # Count default library
  def count_def_lib(display: )
    path = CrypticResolver::Resolver::DEFAULT_LIB_PATH
    default_lib = Dir.children path
    unless default_lib.empty?
      puts "Default library: ".bold.green if display
      default_lib.each do |s|
        next if File.file? path + "/#{s}"
        wc = count_dict_words(path,s)
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
      extra_lib = Dir.children path
      unless extra_lib.empty?
        puts "\nExtra library:".bold.green if display
        extra_lib.each do |s|
          next if File.file? path + "/#{s}"
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


  def reset!
    @word_count_of_two_libs = 0
    @word_count_of_def_lib = 0
    @word_count_of_extra_lib = 0
  end

end
