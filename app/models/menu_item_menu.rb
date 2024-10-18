class MenuItemMenu < ApplicationRecord
  belongs_to :menus
  belongs_to :menu_items
end
