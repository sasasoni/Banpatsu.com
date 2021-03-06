class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :following]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @events = Event.nearest.paginate(page: params[:page], per_page: 10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = I18n.t("flash.event.created")
      redirect_to @event.user
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    # debugger
    if @event.update_attributes(event_params)
      flash[:success] = I18n.t("flash.event.updated")
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = I18n.t("flash.event.destroyed")
    redirect_to current_user
  end

  def calendar
    # Started GET "/calendarevents.json?start=2019-02-24&end=2019-04-07&_=1553599056076"
    # params[:start],params[:end]から日付を取得してカレンダーの期間内のeventを取り出す
    first_date = Time.parse(params[:start])
    last_date = Time.parse(params[:end])
    @events = Event.calendar(first_date, last_date)
    # debugger
  end

  def search
    @events = Event.search(params[:q]).paginate(page: params[:page], per_page: 10)
  end

  private

    def event_params
      params.require(:event).permit(
        :title,
        :description,
        :start_date,
        :end_date,
        :event_url,
        :no_expiration
      )
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end
