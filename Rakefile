desc "count words in sheet `cryptic_computer`"
task :wc do
  ruby "bin/wc"
end

desc "altogether count words in sheet `cryptic_computer`"
task :wc_all do
  ruby "bin/wc --all"
end

desc "update word counts in README"
task :uwc do |t|
  wc = `ruby bin/wc --all`
  badge_url = "https://img.shields.io/badge/Keywords%20Inlcuded-#{wc}-brightgreen"

  file = File.read("./README.md")
  new_file = ""
  file.each_line do |l|
    if l.start_with?("- Currently we have **")
      new_file = new_file + "- Currently we have **#{wc}** keywords explained in our default sheet!! 🎉\n"
    elsif l.start_with?("[![word-count](https://img.shields")
      new_file = new_file + "[![word-count](#{badge_url})][cryptic_computer]\n"
    else
      new_file = new_file + l
    end
  end

  # puts new_file
  
  File.open("README.md","w") do |f|
    File.write f,new_file
  end
end
