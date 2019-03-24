require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  # mail.body.encodedのままだと、メールテキストがBase64でエンコードされた値で出てくるため、テストが合わない。(日本語テキストを挿入した場合に発生)
  def mail_decode(text)
    text.split(/\r\n/).map{ |i| Base64.decode64(i) }.join
  end

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@banpatsu.com"], mail.from
    assert_match user.circle_name, mail_decode(mail.body.encoded)

    assert_match user.activation_token, mail_decode(mail.body.encoded)
    assert_match CGI.escape(user.email), mail_decode(mail.body.encoded)
  end

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@banpatsu.com"], mail.from
    assert_match user.reset_token, mail_decode(mail.body.encoded)
    assert_match CGI.escape(user.email), mail_decode(mail.body.encoded)
  end

end
