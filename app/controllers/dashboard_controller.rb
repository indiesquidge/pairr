class DashboardController < ApplicationController
  def show
    @random_user = User.find(current_user.potential_matches.sample)
  end
end
