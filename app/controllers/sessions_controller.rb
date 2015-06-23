class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:success] = "Welcome #{user.login}"
    else
      redirect_to root_path
    end
  end
end
