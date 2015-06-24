class MatchesController < ApplicationController
  def show
    @random_user = User.find(params[:id])
  end

  def update
    potential_match_id = params[:id].to_i
    status             = params[:status]

    potential_match = Match.find_by(user_id: potential_match_id)
    if potential_match
      if potential_match.status == "pending" && status == "pending"
        potential_match.update_attributes(status: 3)
        Match.create(user_id: current_user.id,
                     potential_match_id: potential_match_id,
                     status: "approved")
        matched_user = User.find(potential_match_id)
        flash[:notice] = "Congrats #{current_user.login}, you and #{matched_user.login} are a good match!"
      end
    end
    Match.create(user_id: current_user.id,
                 potential_match_id: potential_match_id,
                 status: status)

    current_user.potential_matches.delete(potential_match_id)
    current_user.save!

    next_random_user = User.find(current_user.potential_matches.first)
    redirect_to match_path(next_random_user)
  end
end
