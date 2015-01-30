class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :pinterest_id
      t.string :title
      t.text :optional_info
      t.string :source_url #this is the original src url
      t.string :domain_url
      t.string :img_sm_url
      t.string :img_lg_url
      t.integer :like_count
      t.integer :category_id
      
      t.timestamps
    end
  end
end
