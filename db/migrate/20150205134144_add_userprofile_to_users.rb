class AddUserprofileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :userprofile, :text
  end
end
