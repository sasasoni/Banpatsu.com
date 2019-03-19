require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Banpatsu.com"
    assert_equal full_title("Help"), "Help - Banpatsu.com"
  end
end