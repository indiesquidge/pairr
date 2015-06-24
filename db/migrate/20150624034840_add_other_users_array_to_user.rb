class AddOtherUsersArrayToUser < ActiveRecord::Migration
  def change
    add_column :users, :potential_matches, :integer, array: true, default: []
  end
end
