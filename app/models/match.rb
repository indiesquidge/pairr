class Match < ActiveRecord::Base
  belongs_to :user

  enum status: [ :inactive, :pending, :rejected, :matched ]
end
