class Menu < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :menu_items, join_table: :menu_items_menus, dependent: :delete_all
  validates :name, presence: true
end
