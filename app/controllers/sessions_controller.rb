class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    if user
      session[:user_id] = user.id
      if user.languages.empty?
        redirect_to edit_user_path(user)
      else
        redirect_to dashboard_path
        flash[:success] = "Welcome #{user.login}"
      end
      user.save
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
    flash[:success] = "Successfully logged out"
  end
end
