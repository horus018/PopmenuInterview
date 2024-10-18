require 'rails_helper'
require 'fileutils'

RSpec.describe ImportService do
  before(:all) do
    @restaurant_data_dir = Rails.root.join('restaurant_data')
    FileUtils.mkdir_p(@restaurant_data_dir)

    File.open(@restaurant_data_dir.join('valid_data.json'), 'w') do |f|
      f.write <<-JSON
      {
          "restaurants": [
              {
                  "name": "Poppo's Cafe",
                  "menus": [
                      {
                          "name": "lunch",
                          "menu_items": [
                              {
                                  "name": "Burger",
                                  "price": 9
                              },
                              {
                                  "name": "Small Salad",
                                  "price": 5
                              }
                          ]
                      }
                  ]
              }
          ]
      }
      JSON
    end

    File.open(@restaurant_data_dir.join('invalid_restaurant_key.json'), 'w') do |f|
      f.write <<-JSON
      {
          "invalid_restaurants": [
              {
                  "name": "Poppo's Cafe",
                  "menus": [
                      {
                          "name": "lunch",
                          "menu_items": [
                              {
                                  "name": "Burger",
                                  "price": 9
                              }
                          ]
                      }
                  ]
              }
          ]
      }
      JSON
    end

    File.open(@restaurant_data_dir.join('invalid_menu_key.json'), 'w') do |f|
      f.write <<-JSON
      {
          "restaurants": [
              {
                  "name": "Poppo's Cafe",
                  "menus": [
                      {
                          "invalid_menu_key": "lunch",
                          "menu_items": [
                              {
                                  "name": "Burger",
                                  "price": 9
                              }
                          ]
                      }
                  ]
              }
          ]
      }
      JSON
    end

    File.open(@restaurant_data_dir.join('invalid_menu_item_key.json'), 'w') do |f|
      f.write <<-JSON
      {
          "restaurants": [
              {
                  "name": "Poppo's Cafe",
                  "menus": [
                      {
                          "name": "lunch",
                          "menu_items": [
                              {
                                  "invalid_item_key": "Burger",
                                  "price": 9
                              }
                          ]
                      }
                  ]
              }
          ]
      }
      JSON
    end
  end

  after(:all) do
    FileUtils.rm_rf(@restaurant_data_dir)
  end

  before do
    Restaurant.destroy_all
    Menu.destroy_all
    MenuItem.destroy_all
  end

  describe '.import_from_json' do
    context 'with valid JSON data' do
      it 'imports restaurants, menus, and menu items' do
        logs = ImportService.import_from_json(File.open(@restaurant_data_dir.join('valid_data.json')))
        expect(logs).to include("Successfully imported restaurant: Poppo's Cafe")
        expect(Restaurant.count).to eq(1)
        expect(Menu.count).to eq(1)
        expect(MenuItem.count).to eq(2)
      end
    end

    context 'with invalid restaurant key' do
      it 'does not import any data and logs an error' do
        logs = ImportService.import_from_json(File.open(@restaurant_data_dir.join('invalid_restaurant_key.json')))
        expect(logs).to include("No valid restaurant key found.")
        expect(Restaurant.count).to eq(0)
        expect(Menu.count).to eq(0)
        expect(MenuItem.count).to eq(0)
      end
    end

    context 'with invalid menu key' do
      it 'does not import any menu data and logs an error' do
        ImportService.import_from_json(File.open(@restaurant_data_dir.join('valid_data.json'))) # Importar um restaurante válido primeiro
        logs = ImportService.import_from_json(File.open(@restaurant_data_dir.join('invalid_menu_key.json')))
        expect(logs).to include("Successfully imported restaurant: Poppo's Cafe", "Invalid menu data structure for restaurant: Poppo's Cafe")
        expect(Menu.count).to eq(1)
        expect(MenuItem.count).to eq(2)
      end
    end

    context 'with invalid menu item key' do
      it 'does not import any menu item data and logs an error' do
        ImportService.import_from_json(File.open(@restaurant_data_dir.join('valid_data.json'))) # Importar um restaurante válido primeiro
        logs = ImportService.import_from_json(File.open(@restaurant_data_dir.join('invalid_menu_item_key.json')))
        expect(logs).to include("Invalid menu item data structure for menu: lunch, restaurant: Poppo's Cafe")
        expect(MenuItem.count).to eq(2)
      end
    end
  end
end
