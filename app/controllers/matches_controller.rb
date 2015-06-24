class MatchesController < ApplicationController
  def show
    @random_user = User.find(params[:id])
  end

  def update
    potential_match_id = params[:id].to_i
    status             = params[:status]
    Match.create(user_id: current_user.id,
                 potential_match_id: potential_match_id,
                 status: status)

    current_user.potential_matches.delete(potential_match_id)
    current_user.save!

    next_random_user = User.find(current_user.potential_matches.first)
    redirect_to match_path(next_random_user)
  end
end
