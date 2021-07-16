Gem::Specification.new do |s|
  s.name = "cryptic-less"
  s.version = "1.0.2"
  s.date = "2021-07-12"
  
  s.summary = "cr: a general Cryptic Resolver. cr isn't Cryptic Really."

  s.description = <<DESC
This command line tool `cr` is used to record and explain the cryptic commands, acronyms in daily life.
Not only can it be used in computer filed, but also you can use this to manage your own knowledge base easily.
DESC

  s.license = "MIT"

  s.authors = "ccmywish"
  s.email = "leslieranaa@qq.com"
  s.homepage = "https://github.com/cryptic-less"

  s.files = [
  ]

  s.executables = ["cr"]

  s.add_dependency 'tomlrb','~> 2.0'

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/cryptic-less/cr/issues",
    "source_code_uri"   => "https://github.com/cryptic-less/cr"
  }

end