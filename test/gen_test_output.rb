require_relative 'basic_test_sample.rb'

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
  apm
  gdm
]

output = ""

commands.each do
  output += "-----------#{_1}-------------\n"
  output += cr _1
end

# convert the ESC to real \e
output.gsub!("\e", '\e')

File.write('gen_test_output.txt', output)
