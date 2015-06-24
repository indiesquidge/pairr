class UsersController < ApplicationController
  before_filter :authorize_user

  def show
  end

  def edit
    @languages = Language.all
    User.populate_potential_matches(current_user)
  end

  def update
    current_user.languages.delete_all
    user_languages = params[:languages]
    user_languages.each do |lang|
      language = Language.find_by(name: lang)
      current_user.languages << language
    end
    current_user.update_attributes(description: params[:description])
    current_user.save

    redirect_to current_user
  end

  private

  def authorize_user
    redirect_to dashboard_path if current_user.id != params[:id].to_i
  end
end
