desc "count words in default sheet `cryptic_computer`"
task :wc do |t|
  ruby "bin/wc"
end

desc "update word counts in README"
task :uwc do |t|
  wc = `ruby bin/wc --ci`
  badge_url = "https://img.shields.io/badge/Keywords%20Inlcuded-#{wc}-brightgreen"
end