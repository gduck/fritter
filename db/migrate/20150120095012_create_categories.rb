class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :simplified_name
      
      t.timestamps
    end
  end
  add_index :categories, :simplified_name
end
