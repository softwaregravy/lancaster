class CreateWebPageVisits < ActiveRecord::Migration
  def change
    create_table :web_page_visits do |t|
      t.references :web_page, index: true, foreign_key: true
      t.string :checksum
      t.integer :size

      t.timestamps null: false
    end
  end
end
