class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = I18n.t("flash.password_reset.valid_email")
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t("flash.password_reset.invalid_email")
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      # パスワードが空文字(nil)だった場合("   "の場合はuserのvalidate時に検証される)
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = I18n.t("flash.password_reset.succeeded")
      redirect_to @user
    else
      # パスワードが不正だった場合
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :password,
        :password_confirmation
      )
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = I18n.t("flash.password_reset.expired")
        redirect_to new_password_reset_url
      end
    end
end
