class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :Pins, :pininterest_id, :pinterest_id
    rename_column :Pins, :pin_url, :source_url
    change_column :Pins, :optional_info, :text
  end
end
