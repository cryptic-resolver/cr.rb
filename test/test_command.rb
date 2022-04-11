require 'test/unit'

def cr(arg)
  # rake will automatically change to root dir
  `ruby bin/cr #{arg}`
end


class TestCommand < Test::Unit::TestCase

  #
  # You should really care about the spaces when using heredoc!
  #

  def test_emacs

    result = cr("emacs")

    assert_equal(<<~"EOC", result)
  \e[32mFrom: cryptic_computer\e[0m

    Emacs: Edit macros
  
    a feature-rich editor
  
  \e[35mSEE ALSO \e[0m\e[4mVim\e[0m 

  EOC
  end


  def test_jpg
    result = cr("jpg")
    assert_equal(<<~"EOC", result)
    \e[32mFrom: cryptic_computer\e[0m
    \e[34m\e[1mJPG\e[0m\e[0m redirects to \e[34m\e[1mJPEG\e[0m\e[0m

      JPEG: Joint Photographic Experts Group

      Introduced in 1992. A commonly used method of lossy compression for digital images

    EOC
  end


  def test_loc
    result = cr("loc")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m
    \e[34m\e[1mloc\e[0m\e[0m redirects to \e[34m\e[1msloc\e[0m\e[0m

      sloc: Source Lines of Code

    EOC
  end


  def test_bcd
    result = cr("bcd")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m
    \e[34m\e[1mbcd\e[0m\e[0m redirects to \e[34m\e[1mBCDIC\e[0m\e[0m

      BCDIC: Binary-Coded Decimal Interchange Code

      6-bit alphanumeric codes that represented numbers, upper-case letters and special characters. 

    \e[35mSEE ALSO \e[0m\e[4mEBCDIC\e[0m 

    EOC
  end


  def test_gles
    result = cr("gles")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m
    \e[34m\e[1mGLES\e[0m\e[0m redirects to \e[34m\e[1mOpenGL ES\e[0m\e[0m
    
      OpenGL ES: OpenGL for Embedded Systems
    
    EOC
  end


  def test_eg_dot
    result = cr("eg.")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_common\e[0m
    \e[34m\e[1meg.\e[0m\e[0m redirects to \e[34m\e[1m'e.g.'\e[0m\e[0m
    
      e.g.: exempli gratia
    
      The phrase is Latin for 'for example'
    
    \e[35mSEE ALSO \e[0m\e[4mi.e.\e[0m 
    
    EOC
  end


  def test_eg
    result = cr("eg")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_common\e[0m
    \e[34m\e[1meg\e[0m\e[0m redirects to \e[34m\e[1m'eg.'\e[0m\e[0m
    \e[34m\e[1meg.\e[0m\e[0m redirects to \e[34m\e[1m'e.g.'\e[0m\e[0m
    
      e.g.: exempli gratia
    
      The phrase is Latin for 'for example'
    
    \e[35mSEE ALSO \e[0m\e[4mi.e.\e[0m 
    
    EOC
  end


  def test_xdm
    result = cr("xdm")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m

      XDM: eXtreme Download Manager
    
    \e[34m\e[1mOR\e[0m\e[0m
    
      XDM: X Display Manager
    
    EOC
  end


  def test_ide
    result = cr("ide")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m

      IDE: Integrated Development Environment
    
    \e[34m\e[1mOR\e[0m\e[0m
    
      IDE: Integrated Drive Electronics
    
      A type of cable that is used to connect to the motherboard directly. It's the first version of what is now called the ATA/ATAPI, developed by Western Digital
    
    \e[35mSEE ALSO \e[0m\e[4mATA\e[0m 
    
    EOC
  end


  def test_mri
    result = cr("mri")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m

      MRI: Matz's Ruby Interpreter
    
    \e[32mFrom: cryptic_medicine\e[0m
    
      MRI: Magnetic Resonance Imaging
    
    EOC
  end


  def test_gdm
    result = cr("gdm")
    assert_equal(<<~EOC, result)
    \e[32mFrom: cryptic_computer\e[0m

      GDM: GNOME Display Manager
    
      The GNOME Display Manager (GDM) is a program that manages graphical display servers and handles graphical user logins. 
    
    EOC
  end


end
