class AddRestaurantToMenus < ActiveRecord::Migration[7.2]
  def change
    add_reference :menus, :restaurant, null: false, foreign_key: true, index: true
  end
end
