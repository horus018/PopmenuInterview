class RemoveMenuFromMenuItems < ActiveRecord::Migration[7.2]
  def change
    remove_reference :menu_items, :menu, foreign_key: true, index: true
  end
end
