require_relative 'basic.rb'

commands = %w[
  emacs
  jpg
  loc
  bcd
  gles
  eg.
  eg
  xdm
  ide
  mri
  gdm
]

output = ""

commands.each do
  output += "-----------#{_1}-------------\n"
  output += cr _1
end

# convert the ESC to real \e
output.gsub!("\e", '\e')

File.write('gen_output.txt', output)
