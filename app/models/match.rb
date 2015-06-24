class Match < ActiveRecord::Base
  enum status: [ :inactive, :pending, :rejected, :approved ]

  def self.approved_matches(user)
    where(potential_match_id: user.id, status: 3)
  end

  def self.pending_matches(user)
    where.not(user_id: user.id)
    where(potential_match_id: user.id, status: 1)
    .pluck(:user_id)
  end

  def self.pending_matches_first(user)
    pending_matches = pending_matches(user)
    user.potential_matches - pending_matches
    user.potential_matches = pending_matches + user.potential_matches
  end
end
