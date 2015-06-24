class UserLanguages < ActiveRecord::Migration
  def change
    create_table :userlanguages do |t|
      t.integer :user_id
      t.integer :language_id

      t.timestamps null: false
    end
  end
end
