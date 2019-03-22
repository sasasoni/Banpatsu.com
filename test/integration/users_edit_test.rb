require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: "",
      circle_name: "",
      email: "foo@invalid",
      password: "foo",
      password_confirmation: "bar"
    } }

    assert_template 'users/edit'
    assert_select "div.alert-danger"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_equal edit_user_url(@user), session[:forwarding_url]
    log_in_as(@user)
    assert session[:forwarding_url].nil?
    assert_redirected_to edit_user_path(@user)
    name = "Foo Bar"
    circle_name = "FooClub"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: {
      name: name,
      circle_name: circle_name,
      email: email,
      password: "",
      password_confirmation: ""
    } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal circle_name, @user.circle_name
    assert_equal email, @user.email
  end

end
