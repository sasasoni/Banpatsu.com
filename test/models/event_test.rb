require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @event = @user.events.build(title: "Title", description: "this is description", start_date: Time.zone.now)
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "user id should be present" do
    @event.user_id = nil
    assert_not @event.valid?
  end

  test "title should be present" do
    @event.title = "    "
    assert_not @event.valid?
  end

  test "description should be present" do
    @event.description = "    "
    assert_not @event.valid?
  end

  test "start_date should be present" do
    @event.start_date = nil
    assert_not @event.valid?
  end

  test "description should be at most 1000 characters" do
    @event.description = "a" * 1001
    assert_not @event.valid?
  end

  test "order should be most recent first" do
    assert_equal events(:most_recent), Event.first
  end
end
