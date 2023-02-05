def cr(arg)

  if test 'd', 'bin'
    `ruby ./bin/cr #{arg}`
  else
    `ruby ../bin/cr #{arg}`
  end

end

a =  cr("emacs")

b = <<~"EOC"
\e[32mFrom: cryptic_computer\e[0m

  Emacs: Edit macros

  A feature-rich editor

\e[35mSEE ALSO \e[0m\e[4mVim\e[0m

EOC

# notice: only one line left to EOC

puts "#{__FILE__}: Just a small sample before real tests: #{a==b}"
