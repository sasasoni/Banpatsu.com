class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :events_following]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events.most_recent.paginate(page: params[:page], per_page: 10)
    redirect_to root_url and return unless @user.activated?
    # unless @user.activated?
    #   redirect_to root_url
    #   return
    # end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = I18n.t("flash.user.created")
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    # ここでparams[:action]="edit"
    # debugger
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = I18n.t("flash.user.updated")
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t("flash.user.destroyed")
    redirect_to users_url
  end

  def search
    @users = User.search(params[:q_user]).paginate(page: params[:page], per_page: 10)
  end

  def following
    @title = "フォローリスト"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def events_following
    user = User.find(params[:id])
    @following_events = user.following_feed.
      nearest.paginate(page: params[:page], per_page: 10)
  end
  
  private
    
    def user_params
      params.require(:user).permit(
        :name,
        :circle_name,
        :email,
        :profile,
        :twitter_name,
        :site_url,
        :password,
        :password_confirmation
      )
    end

    def correct_user
      # GET   /users/:id/edit
      # PATCH /users/:id
      # GET   /users/:id/events_following
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
