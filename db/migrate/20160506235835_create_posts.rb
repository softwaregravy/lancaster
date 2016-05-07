class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.references :feed, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    # this is brutal. it's basically the entire table
    # using it for now to prevent dupe entries
    # if this gets big, we could just create a hash and unique on that?
    add_index :posts, [:feed_id, :title, :url], unique: true
  end
end
