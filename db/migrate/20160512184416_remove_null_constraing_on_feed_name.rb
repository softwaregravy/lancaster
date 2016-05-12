class RemoveNullConstraingOnFeedName < ActiveRecord::Migration
  def change
    change_column :feeds, :name, :string, null: true
  end
end
