class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :oauth_token, null: false
      t.datetime :oauth_expires_at

      t.timestamps null: false
    end

    add_index :users, :name
    add_index :users, :email, unique: true
    add_index :users, :oauth_token
  end
end
