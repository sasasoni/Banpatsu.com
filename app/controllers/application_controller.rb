class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def hello
    render html: "hello, world!"
  end

  if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::RoutingError,   with: :rescue_not_found
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please Log in."
        redirect_to login_url
      end
    end

    def rescue_not_found(exception)
      render 'errors/not_found', status: 404, formats: [:html]
    end
end
