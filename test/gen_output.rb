require_relative 'basic.rb'

commands = %w[
  emacs
  jpg
  loc
  bcd
  eg.
  eg
  xdm
  ide
  mri
  gdm
]

output = ""

commands.each do
  output += cr _1
  output += "------------------------\n"
end

# convert the ESC to real \e
output.gsub!("\e", '\e')

File.write('gen_output.txt', output)
