class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user      = User.find(params[:id])
    @languages = Language.all
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

    redirect_to user_path(user)
  end
end
