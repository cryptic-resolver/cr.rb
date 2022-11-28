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

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true  
end


desc "Test if rake works"
task :run do 
  ruby "-Ilib ./bin/cr emacs"
end


desc "Generate gen_test_output.txt for tests"
task :gen_test_output do
  ruby "test/gen_test_output.rb"
end


desc "Build and release gem"
task :release do 

  sh 'gem build cr.rb'

  cr_rb = Dir.children('.').select { 
    /cr.rb-(\d)+\.(\d)+(.)*\.gem/.match? _1 
  }.sort.last

  sh "gem push #{cr_rb}"
end
