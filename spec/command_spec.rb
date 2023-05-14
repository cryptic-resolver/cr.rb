require 'minitest/autorun'
require_relative '../lib/cr'

Rainbow.enabled = false

Reslvr = CrypticResolver::Resolver.new

Result = StringIO.new
ORIG_STDOUT = STDOUT

def lookup(word)
  Reslvr.resolve_word word
  Result.rewind
  return Result.read
end

describe CrypticResolver do

  before do
    $stdout = Result
  end

  after do
    $stdout = ORIG_STDOUT
  end

  it "run_first_to_pull_dictionaries_for_ci" do
    # just a random command to let CI pull dictionaries first
    # result = cr("-c", display: true)
  end

  it "lookup 'emacs'" do

    result = lookup 'emacs'

    _(result).must_equal <<~RES
      From: cryptic_computer

        Emacs: Edit macros

        A feature-rich editor

      SEE ALSO Vim

    RES
  end


  it "after" do
  end

end

puts "=> After specs, everything is fine ~"
