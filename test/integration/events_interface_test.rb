require 'test_helper'

class EventsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test "event interface" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'ul.pagination'
    # 無効な送信
    assert_no_difference 'Event.count' do
      post events_path, params: { event: { title: "", description: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "Title!"
    description = "This is Description"
    assert_difference 'Event.count' do
      post events_path, params: { event: {
        title: title,
        description: description,
        start_date: Time.current
      } }
    end
    assert_redirected_to @user
    follow_redirect!
    assert_match title, response.body
    # 投稿を削除
    assert_select 'a', text: 'delete'
    first_event = @user.events.paginate(page: 1).first
    assert_difference 'Event.count', -1 do
      delete event_path(first_event)
    end
    # 違うユーザーのプロフィールにアクセス(削除リンクなし)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
