require_relative 'lib/cr/version'

Gem::Specification.new do |s|
  s.name = "cr.rb"
  s.version = CrypticResolver::GEM_VERSION
  require 'date'
  s.date = Date.today.to_s

  s.authors = "Aoran Zeng"
  s.email   = "ccmywish@qq.com"

  s.homepage = "https://github.com/cryptic-resolver/cr.rb"
  s.summary  = "Resolve cryptic commands/acronyms on the command line"

  s.description = <<DESC
This command line tool `cr` is used to record and explain cryptic commands, acronyms(initialism), abbreviations and so forth in daily life.
Not only can it be used in computer filed via our default sheet cryptic_computer, but also you can use this to manage your own knowledge base easily.
DESC

  s.license = "MIT"

  s.files = Dir['lib/**/*']
  s.require_paths = ['lib']
  s.bindir = 'exe'
  s.executables = ['cr']

  s.add_dependency 'tomlrb',        '~> 2.0'
  s.add_dependency 'ls_table',      '~> 0.1'
  s.add_dependency 'rainbow',       '~> 3.1'
  s.add_dependency 'standard_path', '~> 0.1'

  s.required_ruby_version = ">= 3.0.0"

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/cryptic-resolver/cr.rb/issues",
    "source_code_uri"   => "https://github.com/cryptic-resolver/cr.rb"
  }

end
