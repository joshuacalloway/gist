require 'test/unit'
require 'gistmeetup'

class GistmeetupTest < Test::Unit::TestCase
  def test_hello
    assert_equal "Hi GistMeetup",
      Gistmeetup.hi
  end
end
