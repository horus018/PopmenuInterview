# 🥗 Import Service Documentation

The **ImportService** is a Ruby on Rails service designed to import restaurant data from a JSON file. This service handles various data structures and provides detailed logs for each operation.

---

## 📡 Endpoint

To trigger the import service, use the following route:

**POST** `/import`

---

## 📝 Request

The request should contain a JSON file with the restaurant data. The file can be passed as a parameter named **file**.

---

## 📊 Data Structure

The service expects the JSON data to follow a specific structure. Here’s an example of a valid JSON input:

```json
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
```

## 🔑 Valid Keys

- Restaurant Keys: Restaurant, restaurant, RESTAURANT, Restaurants, restaurants, RESTAURANTS
- Menu Keys: menu, Menu, MENU, menus, Menus, MENUS
- Menu Item Keys: menu_items, MenuItems, MENU_ITEMS, dishes, Dishes, DISHES

## ⚙️ Import Process
The import process includes the following steps:

- File Reading: The service reads the JSON file.
- Key Validation: It searches for valid keys for restaurants, menus, and menu items.
- Data Importing: The service imports the data, logging each action taken, including successes and failures.

## 📜 Logs
The service returns an array of logs that detail the import process:

- Success: Logs indicating successful imports (e.g., "Successfully imported restaurant: Poppo's Cafe").
- Errors: Logs indicating issues encountered (e.g., "No valid restaurant key found").

## 🧪 Tests
The service is tested using RSpec. Here are the main test scenarios:

- Valid JSON Data: Checks that restaurants, menus, and menu items are correctly imported.
- Invalid Restaurant Key: Ensures that no data is imported and an error is logged.
- Invalid Menu Key: Validates that the restaurant is imported, but the menu fails.
- Invalid Menu Item Key: Verifies that the menu is imported but fails for menu items.

## 🔍 Example Test
Here’s an example test for valid JSON data:

```ruby
it 'imports restaurants, menus, and menu items' do
  logs = ImportService.import_from_json(File.open('valid_data.json'))
  expect(logs).to include("Successfully imported restaurant: Poppo's Cafe")
  expect(Restaurant.count).to eq(1)
  expect(Menu.count).to eq(1)
  expect(MenuItem.count).to eq(2)
end
```

## ⚠️ Error Handling
The service includes error handling for various exceptions:

- JSON Parsing Error: Returns a 422 Unprocessable Entity status if the JSON is invalid.
- General Errors: Catches standard errors and returns a 500 Internal Server Error status.

## 🏁 Conclusion
The ImportService provides a robust way to import restaurant data with extensive logging and error handling, making it easy to debug and understand the import process.

For further assistance, please refer to the source code or contact the development team. Happy coding! 🎉