class StaticPagesController < ApplicationController
  def home
    @events = Event.new_events
    @following_events = current_user.following_feed.
      nearest.take(5) if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
