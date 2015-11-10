class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :pid, null: false
      t.string :name, null: false
      t.string :imageUrl
      t.string :email, null: false
      t.time :last_login

      t.timestamps null: false
    end

    add_index :users, :name
    add_index :users, :email, unique: true
  end
end
