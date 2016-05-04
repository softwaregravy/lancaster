class CreateUserModelJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :roles do |t|
      t.index [:user_id, :role_id]
      t.index [:role_id, :user_id]
      t.timestamps null: false
    end
  end
end
