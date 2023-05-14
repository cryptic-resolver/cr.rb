# ---------------------------------------------------------------
# File          : Rakefile
# Authors       : ccmywish <ccmywish@qq.com>
# Created on    : <2021-07-16>
# Last modified : <2023-05-14>
# Contributors  :
#
# Rakefile:
#
#   Development tasks.
# ---------------------------------------------------------------

desc "Count words in all dictionaries"
task :wc do
  ruby "bin/wc"
end


desc "Altogether count words in all dictionaries"
task :wc_all do
  ruby "bin/wc --all"
end


desc "Update word counts in README"
task :uwc do |t|
  ruby "bin/wc --uwc"
end


require 'rake/testtask'

Rake::TestTask.new :spec do |s|
  s.libs << "spec"
  s.test_files = FileList['spec/*_spec.rb']
  s.verbose = true
end


desc "Build the gem"
task :build do
  rm_f '*.gem'
  # sh 'gem build cr.rb'
end


desc "Release the gem"
task :release do
  cr_rb = Dir.children('.').select {
    /cr.rb-(\d)+\.(\d)+(.)*\.gem/.match? _1
  }.sort.last

  sh "gem push #{cr_rb}"
end


desc "Generate signatures"
task :sig do
  system 'typeprof -Ilib exe\cr lib\**.rb -o sig\cr.rbs'
end
