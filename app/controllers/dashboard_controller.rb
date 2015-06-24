class DashboardController < ApplicationController
  def show
    Match.pending_matches_first(current_user)

    @random_user = User.find(current_user.potential_matches.first)
  end
end
