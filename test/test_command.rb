require 'test/unit'

def cr(arg)
  # rake will automatically change to root dir
  `ruby bin/cr #{arg}`
end


class TestCommand < Test::Unit::TestCase

  def test_emacs

    result = cr("emacs")

    assert_equal(<<~"EOC", result)
  \e[32mFrom: cryptic_computer\e[0m

    Emacs: Edit macros
  
    a feature-rich editor
  
  \e[35mSEE ALSO \e[0m\e[4mVim\e[0m 

  EOC

  end


end
