class RenameAndIndexUpjoinsToLikes < ActiveRecord::Migration
  def change
    rename_table :upjoins, :likes

    add_index :likes, :user_id
    add_index :likes, :pin_id
  end
end
