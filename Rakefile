desc "Count words in all dictionaries"
task :wc do
  ruby "bin/wc"
end

desc "Altogether count words in all dictionaries"
task :wc_all do
  ruby "bin/wc --all"
end


def update_wc_en
  wc = `ruby bin/wc --all`
  badge_url = "https://img.shields.io/badge/Keywords%20Inlcuded-#{wc}-brightgreen"

  file = File.read("./README.md")
  new_file = ""
  file.each_line do |l|
    if l.start_with?("- Currently we have **")
      new_file = new_file + "- Currently we have **#{wc}** keywords explained in our default sheets.\n"
    elsif l.start_with?("[![word-count](https://img.shields")
      new_file = new_file + "[![word-count](#{badge_url})](#default-sheets)\n"
    else
      new_file = new_file + l
    end
  end

  # puts new_file
  
  File.open("README.md","w") do |f|
    File.write f,new_file
  end
end


desc "Update word counts in README"
task :uwc do |t|
  update_wc_en
end

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true  
end

desc "Generate gen_output.txt for tests"
task :gen_output do
  ruby "test/gen_output.rb"
end
