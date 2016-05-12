class CreateWebPages < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.string :url

      t.timestamps null: false
    end
    add_index :web_pages, :url, unique: true
  end
end
