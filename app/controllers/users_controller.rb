class UsersController < ApplicationController
  before_filter :authorize_user

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user      = User.find(params[:id])
    @languages = Language.all
    User.populate_potential_matches(current_user)
  end

  def update
    user = User.find(params[:id])
    user.languages.delete_all
    user_languages = params[:languages]
    user_languages.each do |lang|
      language = Language.find_by(name: lang)
      user.languages << language
    end
    user.update_attributes(description: params[:description])
    user.save

  def authorize_user
    redirect_to dashboard_path if current_user.id != params[:id].to_i
  end
end
