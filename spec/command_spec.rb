# ---------------------------------------------------------------
# File          : command_spec.rb
# Authors       : Aoran Zeng <ccmywish@qq.com>
# Created on    : <2023-05-14>
# Last modified : <2023-05-14>
#
# command_spec:
#
#   Test predefined representative words
# ---------------------------------------------------------------

require 'minitest/autorun'
require_relative '../lib/cr'

Rainbow.enabled = false

Reslvr = CrypticResolver::Resolver.new

#========= Two Simple Tests ============
# let CI pull dictionaries first
Reslvr.add_default_dicts_if_none_exists

Reslvr.count_words
#=======================================

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


  it "lookup 'gles'" do
    result = lookup 'gles'
    _(result).must_equal <<~RES
    From: cryptic_computer
    GLES redirects to OpenGL ES

      OpenGL ES: OpenGL for Embedded Systems

    RES
  end


  it "lookup 'eg.'" do
    result = lookup 'eg.'
    _(result).must_equal <<~RES
    From: cryptic_common
    eg. redirects to 'e.g.'

      e.g.: exempli gratia

      The phrase is Latin for 'for example'

    SEE ALSO i.e.

    RES
  end


  it "lookup 'eg'" do
    result = lookup 'eg'
    _(result).must_equal <<~RES
    From: cryptic_common
    eg redirects to 'eg.'
    eg. redirects to 'e.g.'

      e.g.: exempli gratia

      The phrase is Latin for 'for example'

    SEE ALSO i.e.

    RES
  end


  it "lookup 'xdm" do
    result = lookup 'xdm'
    _(result).must_equal <<~RES
    From: cryptic_computer

      XDM: eXtreme Download Manager

    OR

      XDM: X Display Manager

    RES
  end


  it "lookup 'ide'" do
    result = lookup 'ide'
    _(result).must_equal <<~RES
    From: cryptic_computer

      IDE: Integrated Development Environment

    OR

      IDE: Integrated Drive Electronics

      A type of cable that is used to connect to the motherboard directly. It's the first version of what is now called the ATA/ATAPI, developed by Western Digital

    SEE ALSO ATA

    RES
  end



  it "lookup apm" do
    result = lookup 'apm'
    _(result).must_equal <<~RES
    From: cryptic_computer

      APM: Application performance management

    From: cryptic_windows

      APM: Advanced Power Management

      It was developed by Microsoft and Intel around 1992, as a way to provide power management on Intel PCs

    RES
  end


  it "lookup gdm" do
    result = lookup 'gdm'
    _(result).must_equal <<~RES
    From: cryptic_computer

      GDM: GNOME Display Manager

      The GNOME Display Manager (GDM) is a program that manages graphical display servers and handles graphical user logins.

    RES
  end

end
