require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: {
        name: "",
        circle_name: "sasaclub",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
      } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
    assert_select 'li', "Name can't be blank"
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: {
        name: "Example User",
        circle_name: "ExampleClub",
        email: "user@example.com",
        password: "password",
        password: "password"
      } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
