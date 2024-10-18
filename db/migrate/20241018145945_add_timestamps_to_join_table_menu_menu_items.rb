class AddTimestampsToJoinTableMenuMenuItems < ActiveRecord::Migration[7.2]
  def change
    change_table :menu_items_menus do |t|
      t.timestamps
    end
  end
end
