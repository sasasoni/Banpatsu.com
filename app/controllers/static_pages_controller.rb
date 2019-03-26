class StaticPagesController < ApplicationController
  def home
    @events = Event.new_events
  end

  def help
  end

  def about
  end

  def contact
  end
end
