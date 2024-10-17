# README

This project is intended to solve the levels of the interview challenge for Popmenu.

## 🌟 Rails Project Setup and Implementation

- **🔧 Created and ran migrations for** `Menu`, `MenuItem`, and `Restaurant`:
  - **🍽️ `Menu`** has a **🔑 name** and multiple **🍽️ `MenuItems`**.
  - **🍽️ `MenuItem`** has a **🔑 name** and **💰 price**.
  - **🍽️ `Restaurant`** has a **🔑 name** and multiple **🍽️ `Menus`**.

- **📦 Created and updated models** to define **🔗 relationships** and **✅ validations**.
  - Implemented many-to-many associations between **🍽️ `Menu`** and **🍽️ `MenuItem`**.

- **🔄 Populated controllers** for **🍽️ Menu**, **🍽️ MenuItem**, and **🍽️ Restaurant**

- **🛤️ Populated routes** to handle **RESTful actions**:
  - Added routes for **🍽️ Menu**, **🍽️ MenuItem**, and **🍽️ Restaurant** in `config/routes.rb`.

- **🔍 Installed RSpec for testing:**
  - Command: `bundle exec rails g rspec:install`
  - Command: `bundle exec rspec` to run tests.

- **⚙️ Ran database setup and migrations:**
  - Command: `bundle exec rails db:create` (for creating the **🗄️ database**)
  - Command: `bundle exec rails db:migrate` (for applying **📜 migrations**)

- **🔄 Ran migrations for the test database:**
  - Command: `rake db:migrate RAILS_ENV=test`

- **📦 Installed dependencies:**
  - Command: `bundle install`

- **⚙️ All commands located in `commands.txt` file**