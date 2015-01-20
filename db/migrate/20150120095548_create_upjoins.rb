class CreateUpjoins < ActiveRecord::Migration
  def change
    create_table :upjoins do |t|
      t.integer :user_id
      t.integer :pin_id
      t.text :description

      t.timestamps
    end
  end
end
