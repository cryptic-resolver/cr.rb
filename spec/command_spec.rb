require 'minitest/autorun'
require_relative '../lib/cr'

Rainbow.enabled = false

Reslvr = CrypticResolver::Resolver.new
Result = StringIO.new
ORIG_STDOUT = STDOUT

def lookup(word)
  Reslvr.resolve_word word
  Result.rewind
  cont = Result.read
  Result.rewind
  Result.truncate(0)
  return cont
end

describe CrypticResolver do

  before do
    $stdout = Result
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


  it "lookup 'jpg'" do
    result = lookup 'jpg'
    _(result).must_equal <<~RES
    From: cryptic_computer
    JPG redirects to JPEG

      JPEG: Joint Photographic Experts Group

      Introduced in 1992. A commonly used method of lossy compression for digital images

    RES
  end


  it "lookup 'loc" do
    result = lookup 'loc'
    _(result).must_equal <<~RES
    From: cryptic_computer
    loc redirects to sloc

      sloc: Source Lines of Code

    RES
  end


  it "lookup 'bcd'" do
    result = lookup 'bcd'
    _(result).must_equal <<~RES
    From: cryptic_computer
    bcd redirects to BCDIC

      BCDIC: Binary-Coded Decimal Interchange Code

      6-bit alphanumeric codes that represented numbers, upper-case letters and special characters.

    SEE ALSO EBCDIC

    RES
  end

end
