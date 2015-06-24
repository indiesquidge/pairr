class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :potentail_match_id
      t.integer :status, default: 0
    end
  end
end
