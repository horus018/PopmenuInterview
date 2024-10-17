ActiveRecord::Schema[7.2].define(version: 2024_10_16_191222) do
  create_table "menu_items", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "menu_items", "menus"
end
