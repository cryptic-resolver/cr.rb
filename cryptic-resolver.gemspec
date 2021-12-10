Gem::Specification.new do |s|
  s.name = "cryptic-resolver"
  s.version = "2.3"
  s.date = "2021-12-10"
  
  s.summary = "cr: Cryptic Resolver"

  s.description = <<DESC
This command line tool `cr` is used to record and explain cryptic commands, acronyms and so forth in daily life.
Not only can it be used in computer filed via our default sheet cryptic_computer, but also you can use this to manage your own knowledge base easily.
DESC

  s.license = "MIT"

  s.authors = "ccmywish"
  s.email = "ccmywish@qq.com"
  s.homepage = "https://github.com/cryptic-resolver/cr"

  s.files = [
  ]

  s.executables = ["cr"]

  s.add_dependency 'tomlrb','~> 2.0'

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/cryptic-resolver/cr/issues",
    "source_code_uri"   => "https://github.com/cryptic-resolver/cr"
  }

end