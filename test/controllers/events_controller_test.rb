require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @event = events(:one)
  end

  test "should redirect new when not looged in" do
    get new_event_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Event.count' do
      post events_path, params: { event: {
        title: "title",
        description: "this is desc",
        start_date: Time.current
      } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Event.count' do
      delete event_path(@event)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong event" do
    log_in_as(users(:michael))
    event = events(:ants)
    assert_no_difference 'Event.count' do
      delete event_path(event)
    end
    assert_redirected_to root_url
  end
end
