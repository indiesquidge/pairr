class DashboardController < ApplicationController
  def show
    Match.pending_matches_first(current_user)

    @random_user = User.find(current_user.potential_matches.first)

    approved_matches = Match.approved_matches(current_user)
    @approved_pairs  = approved_matches.map do |match|
      User.find(match.user_id)
    end
  end
end
