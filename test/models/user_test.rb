require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", circle_name: "Examples", email: "user@example.com", password: "foobar", password_confirmation: "foobar", profile: "This is profile.",
    twitter_name: "sasasoni1119", site_url: "http://www.example.com")
  end
  # test "the truth" do
  #   assert true
  # end
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "circle_name should be present" do
    @user.circle_name = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "circle_name should not be too long" do
    @user.circle_name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.com user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "site_url validation should accept valid urls" do
    valid_urls = %w[http://utbc.jp https://utbc.jp/ http://www.fm-shibaya.com/ https://www.mubs-web.com/ https://ticklecode.com/honoka-install/ https://twitter.com/sasasoni1119]
    valid_urls.each do |valid_url|
      @user.site_url = valid_url
      assert @user.valid?, "#{valid_url.inspect} shoud be valid"
    end
    @user.site_url = ' '
    assert @user.valid?
  end

  test "site_url validation should reject invalid urls" do
    invalid_urls = %w[http:/utbc.jp ftp://example.com http://www.fm-shibaya,com/ http://.com abc]
    invalid_urls.each do |invalid_url|
      @user.site_url = invalid_url
      assert_not @user.valid?, "#{invalid_url.inspect} should be invalid"
    end
  end
end
