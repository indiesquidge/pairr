class AddUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatar_url
      t.string :provider
      t.string :token
      t.string :uid

      t.timestamps null: false
    end
  end
end
