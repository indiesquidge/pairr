class MatchingController < ApplicationController
  def show
    @random_user = User.find(params[:id])
  end
end
