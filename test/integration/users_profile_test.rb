require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.circle_name)
    assert_select 'h4.card-title', text: @user.circle_name
    assert_select 'h6>img.gravatar'
    assert_select 'ul.pagination'
    @user.events.most_recent.paginate(page: 1, per_page: 10).each do |event|
      assert_match event.title, response.body
    end
  end
end
