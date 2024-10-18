class ImportService
  VALID_RESTAURANT_KEYS = %w[Restaurant restaurant RESTAURANT Restaurants restaurants RESTAURANTS].freeze
  VALID_MENU_KEYS = %w[menu Menu MENU menus Menus MENUS].freeze
  VALID_MENU_ITEM_KEYS = %w[menu_items MenuItems MENU_ITEMS dishes Dishes DISHES].freeze

  def self.import_from_json(file)
    json_data = JSON.parse(file.read)
    logs = []

    restaurant_key = find_valid_key(json_data, VALID_RESTAURANT_KEYS)

    unless restaurant_key
      logs << "No valid restaurant key found."
      return logs
    end

    json_data[restaurant_key].each do |restaurant_data|
      unless valid_keys?(restaurant_data, %w[name menus])
        logs << "Invalid restaurant data structure for: #{restaurant_data['name'] || 'Unknown'}"
        next
      end

      restaurant = Restaurant.create(name: restaurant_data["name"])
      if restaurant.persisted?
        logs << "Successfully imported restaurant: #{restaurant.name}"

        menu_key = find_valid_key(restaurant_data, VALID_MENU_KEYS)
        unless menu_key
          logs << "No valid menu key found for restaurant: #{restaurant.name}"
          next
        end

        restaurant_data[menu_key].each do |menu_data|
          unless valid_keys?(menu_data, %w[name menu_items dishes])
            logs << "Invalid menu data structure for restaurant: #{restaurant.name}"
            next
          end

          menu = restaurant.menus.create(name: menu_data["name"])
          if menu.persisted?
            logs << "Successfully imported menu: #{menu.name} for restaurant: #{restaurant.name}"

            menu_items_key = find_valid_key(menu_data, VALID_MENU_ITEM_KEYS)
            unless menu_items_key
              logs << "No valid menu item key found for menu: #{menu.name}, restaurant: #{restaurant.name}"
              next
            end

            menu_data[menu_items_key].each do |menu_item_data|
              unless valid_keys?(menu_item_data, %w[name price])
                logs << "Invalid menu item data structure for menu: #{menu.name}, restaurant: #{restaurant.name}"
                next
              end

              menu_item = MenuItem.find_or_create_by(name: menu_item_data["name"], price: menu_item_data["price"])
              if menu_item.valid? && !menu.menu_items.exists?(menu_item.id)
                menu.menu_items << menu_item
                logs << "Successfully imported menu item: #{menu_item.name} for menu: #{menu.name}, restaurant: #{restaurant.name}"
              else
                logs << "Failed to import menu item: #{menu_item_data['name']}, possibly duplicate for menu: #{menu.name}, restaurant: #{restaurant.name}"
              end
            end
          else
            logs << "Failed to import menu: #{menu_data['name']} for restaurant: #{restaurant.name}, Errors: #{menu.errors.full_messages.join(', ')}"
          end
        end
      else
        logs << "Failed to import restaurant: #{restaurant_data['name']}, Errors: #{restaurant.errors.full_messages.join(', ')}"
      end
    end

    logs
  end

  private

  def self.find_valid_key(data, valid_keys)
    data.keys.find { |key| valid_keys.include?(key) }
  end

  def self.valid_keys?(data, valid_keys)
    (data.keys - valid_keys).empty?
  end
end
